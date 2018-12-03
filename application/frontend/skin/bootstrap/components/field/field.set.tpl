{**
 * Набор полей
 *}

{extends 'component@field.field'}

{block 'field_options' append}
    {component_define_params params=[ 'items', 'isAllowUpdate', 'name' ]}
{/block}

{block 'field_input'}
    
    <div class="{$component}-set js-fieldset" {field_input_attr_common}>
        <ul class="{$component}-set-list js-fieldset-list">
            
            {if {$items|sizeof}}
                {foreach $items as $item}
                    {component 'field.set-item'
                        params    = $item
                        allowUpdate = $isAllowUpdate
                        allowRemove = true}
                {/foreach}
            {else}
                {if {$_aRequest[{$name}]|@sizeof}}
                    {foreach $_aRequest[{$name}] as $id => $value}
                        {component 'field.set-item'
                            name    = $name
                            id      = $id
                            value   = $value
                            allowUpdate = $isAllowUpdate
                            allowRemove = true}
                    {/foreach}
                {else}
                    {component 'field.set-item' name=$name showRemove=false}
                    {component 'field.set-item' name=$name showRemove=false}
                {/if}
                
            {/if}
        </ul>

        {if $isAllowUpdate}
            <footer class="fieldset-footer">
                {component 'button'
                    type       = 'button'
                    text       = $aLang.common.add
                    attributes = [ 'title' => '[Ctrl + Enter]' ]
                    classes    = 'js-fieldset-item-add'}
            </footer>
        {/if}
        
    {* Шаблон поля для добавления с помощью js *}
    {component 'field.set-item' name=$name isTemplate=true}
    </div>
        
{/block}