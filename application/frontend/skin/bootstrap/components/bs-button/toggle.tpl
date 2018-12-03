{**
 * Группа кнопок переключателей
 *
 * @param string  $classes        Список классов основного блока (через пробел)
 * @param array   $attributes     Список атрибутов основного блока
 * @param array   $items     Список атрибутов основного блока
 *}

{$component = "btn"}
 
{component_define_params params=[ 'items', 'classes', 'attributes' ]}

{block 'button_toggle_content'}
    <div class="btn-group btn-group-toggle {$classes}" {cattr list=$attributes} data-toggle="buttons">
        {foreach $items as $item}
            <label class="{$component} {bmods bmods=$item.bmods} {$item.classes}" {cattr list=$item.attributes}>
                <input type="radio" name="{$item.name}" id="{$item.id}"
                       autocomplete="off" {if $item.checked}checked{/if}> {$item.text}
            </label>
        {/foreach}
    </div>   
{/block}