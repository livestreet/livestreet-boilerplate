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
            {$isActive = ($activeItem and $item.name == $activeItem) or $item.active}
            {if $item.menu}
                {component "bs-dropdown" params=$item.menu tag="li"
                    toggler=[
                        com => "nav-link",
                        url=>"#",
                        classes=>"dropdown-toggle {$item.menu.classes} {$itemsClasses}",
                        text=>$item.menu.text
                    ]
                }
            {else}
                <li class="nav-item">
                    <a class="nav-link  {$itemsClasses} {$item.classes} 
                        {if $isActive}active{/if} {if $item.disabled}disabled{/if}" href="{$item.url}"
                        {cattr list=$item.attributes}>
                        {if $item.badge}
                            {if is_array($item.badge)}
                                {component "bs-badge" prrams=$item.badge}
                            {else}
                                {component "bs-badge" text=$item.badge bmods="primary"}
                            {/if}                    
                        {/if}
                        {$item.text}
                    </a>
                </li>
            {/if}            
        {/foreach}
    </ul>
{/strip}{/block}

