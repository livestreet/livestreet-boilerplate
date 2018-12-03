{**
 * Tabs
 *
 * @param array $tabs Табы. Структура: [ 'text', 'content' ]
 *}

{$component = 'ls-tabs'}
{component_define_params params=[ 'activeTab', 'tabs', 'mods', 'classes', 'attributes' ]}

{block 'tabs_options'}{/block}

{* Уникальный ID для привязки таба к его содержимому *}
{foreach $tabs as $tab}
    {$tabs[ $tab@index ][ 'uid' ] = "tab{mt_rand()}"}
{/foreach}

<div class="{$component} {cmods name=$component mods=$mods} {$classes}" {cattr list=$attributes}>
    {* Табы *}
    {component 'tabs.list' activeTab=$activeTab tabs=$tabs}

    {* Содержимое табов *}
    {if ! $activeTab && $tabs}
        {$tabs[0]['isActive'] = true}
    {/if}

    <div class="ls-tabs-panes" data-tab-panes>
        {foreach $tabs as $tab}
            {if $tab[ 'is_enabled' ]|default:true}
                <div class="ls-tab-pane" {if $tab['isActive'] || ($activeTab && $tab['name'] == $activeTab)}style="display: block"{/if} data-tab-pane id="{$tab[ 'uid' ]}">
                    {if $tab[ 'content' ]}
                        <div class="ls-tab-pane-content">
                            {$tab[ 'content' ]}
                        </div>
                    {/if}

                    {* Item group *}
                    {if is_array( $tab[ 'list' ] )}
                        {component 'item' template='group' params=$tab[ 'list' ]}
                    {elseif $tab[ 'list' ]}
                        {$tab[ 'list' ]}
                    {/if}

                    {$tab[ 'body' ]}
                </div>
            {/if}
        {/foreach}
    </div>
</div>