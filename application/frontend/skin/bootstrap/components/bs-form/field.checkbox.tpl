{**
 * Флажок
 *
 * @param boll  $disabled           Отключено
 * @param boll  $inline             На одной строке
 * @param boll  $radio              Выбор
 * @param boll  $checked            Выбран
 * 
 *}
 
{extends "component@bs-form.field"}

{component_define_params params=[ 'disabled', 'inline', 'radio', 'checked', 'custom']}

{block name="field_options"}
    {$component = "form-check"}
    
    {if $custom}
        {$component = "custom-control"}
    {else}
        {$componentGroup= "form-check"}
    {/if}
    {if $radio}
        {$attributes.type = 'radio'}
        {$type = 'radio'}
    {else}
        {$attributes.type = 'checkbox'}
    {/if}
    
    {if $inline}
        {$bmodsGroup = "inline"}
    {/if}
    
    {if $checked}
        {$attributes.checked = true}
    {/if}
    
    {if $disabled}
        {$attributes.disabled = true}
    {/if}
    
{/block}

{block name="field_content"}
    <input class="{$component}-input {cmods name=$component mods=$bmods delimiter="-"} {$classes}" {cattr list=$attributes} >
    {if $label}
        <label class="{$component}-label" for="{$attributes.id}">{$label}</label>
    {/if}
{/block}


    


