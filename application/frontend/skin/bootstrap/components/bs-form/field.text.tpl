{**
 * Текст
 *
 * @param string  $readonly          Список классов основного блока (через пробел)
 * 
 *}
 
{extends "component@bs-form.field"}

{component_define_params params=[ 'readonly']}

{block name="field_input"}
    <input type="{$type|default:'text'}" 
           class="{$component} {cmods name=$component mods=$bmods delimiter="-"} {$classes}" 
           {attr_rules id=$attributes.id} {cattr list=$attributes} {if $readonly}readonly{/if}>
{/block}
    


