{**
 * Табы
 *
 * @param array     $items
 * @param string    $activeItem
 * @param string    $justify        Горизонтальное выравнивание
 * @param bool      $vertical       
 * 
 *}
{component_define_params params=[ 'items', 'activeItem', 'classes', 'attributes', 'bmods' ]}

{block 'tabs_content'}{strip}
    <nav>
        <div class="nav mb-3{$classes} {cmods name="nav" mods=$bmods delimiter="-"} " id="nav-tab" role="tablist" {cattr list=$attributes}>
            {foreach $items as $item name="tabs"}
                {$isActive = $item.active}
                {if $activeItem}
                    {$isActive = ($activeItem == $item.name) }
                {/if}
                
                <a class="nav-item nav-link {if $isActive}active{/if}" 
                   id="nav-tab-{$smarty.foreach.tabs.index}" 
                   data-toggle="tab" 
                   href="#nav-pane-{$smarty.foreach.tabs.index}" 
                   role="tab" 
                   aria-controls="nav-pane-{$smarty.foreach.tabs.index}" 
                   aria-selected="{if $isActive}true{else}false{/if}">{$item.text}</a>
            
            {/foreach}

        </div>
    </nav>
    <div class="tab-content" id="nav-tabContent">
        {foreach $items as $item name="panes"}
            {$isActive = $item.active}
            {if $activeItem}
                {$isActive = ($activeItem == $item.name) }
            {/if}

            <div class="tab-pane fade {if $isActive}show active{/if}" 
                 id="nav-pane-{$smarty.foreach.panes.index}" 
                 role="tabpanel" 
                 aria-labelledby="nav-tab-{$smarty.foreach.panes.index}">
                {$item.content}
            </div>

        {/foreach}
    </div>
{/strip}{/block}

