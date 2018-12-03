{**
 * Файл
 *
 * @param boll  $disabled           Отключено
 * @param boll  $inline             На одной строке
 * @param boll  $radio              Выбор
 * @param boll  $checked            Выбран
 * 
 *}
 
{extends "component@bs-form.field"}

{component_define_params params=[ 'disabled']}

{block name="field_options"}
    {$component = "form-check"}
    
    {if $custom}
        {$component = "custom-file"}
    {else}
        {$componentGroup= "form-check"}
    {/if}
        
    {if $disabled}
        {$attributes.disabled = true}
    {/if}
    
{/block}

{block name="field_content"}
    <input type="{$type}" class="{$component}-input {cmods name=$component mods=$bmods delimiter="-"} {$classes}" {cattr list=$attributes}>
    {if $label}
        <label class="{$component}-label" for="{$attributes.id}">{$label}</label>
    {/if}
{/block}




