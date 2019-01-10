{**
 * Навигация
 *
 * @param array     $items
 * @param string    $activeItem
 * @param string    $justify        Горизонтальное выравнивание
 * @param bool      $vertical       
 * 
 *}
{$component = "nav"}
{component_define_params params=[ 'items', 'activeItem', 'justify', 'vertical', 'isRoot', 'hook', 'classes', 'attributes', 'bmods', 
    'itemsClasses' ]}

{* Получаем пункты установленные плагинами *}
{if $hook}
    {hook run="nav_{$hook}" assign='hookItems' params=$hookParams items=$items array=true}
    {$items = ( $hookItems ) ? $hookItems : $items}
{/if}

{if $justify}
    {$classes = "{$classes} justify-content-{$justify}"}
{/if}
{if $vertical}
    {$classes = "{$classes} flex-column"}
{/if}

{block 'nav_content'}{strip}
    <ul class="{$component} {cmods name=$component mods=$bmods delimiter="-"} {$classes}" {cattr list=$attributes}>
        {foreach $items as $item}
            {if !is_array($item)}
                {$item}
            {else}
                {$isActive = ($activeItem and $item.name == $activeItem) or $item.active}
                {if $item.menu}
                    {component "bs-dropdown" params=$item.menu tag="li"
                        text = $item.text
                        toggler=[
                            com => "nav-link",
                            url=>"#",
                            classes=>"dropdown-toggle {$item.menu.classes} ",
                            text=>$item.text
                        ]
                    }
                {else}

                    <li class="nav-item  {$item.liClasses}">
                        <a class="nav-link  {$itemsClasses} {$item.classes}  {if $isActive}active{/if}
                             {if $item.disabled}disabled{/if}" href="{$item.url}"
                            {cattr list=$item.attributes}>
                            {if $item.icon}
                                {if is_array($item.icon)}
                                    {component "bs-icon" params=$item.icon}
                                {else}
                                    {component "bs-icon" icon=$item.icon}
                                {/if}                    
                            {/if}
                            {$item.text}{if $item.badge}
                                {if is_array($item.badge)}
                                    {component "bs-badge" params=$item.badge}
                                {else}
                                    {component "bs-badge" text=$item.badge bmods="light"}
                                {/if}                    
                            {/if}
                            {if $item.count}
                                {if is_array($item.count)}
                                    {component "bs-badge" params=$item.count}
                                {else}
                                    {component "bs-badge" 
                                        text        = $item.count 
                                        attributes  = ["data-count-{$item.name}" => true] 
                                        bmods       = "light"}
                                {/if}                    
                            {/if}
                        </a>
                    </li>
                {/if}
            {/if}            
        {/foreach}
    </ul>
{/strip}{/block}

