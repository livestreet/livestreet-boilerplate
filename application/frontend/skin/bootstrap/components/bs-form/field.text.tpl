{**
 * Текст
 *
 * @param string  $readonly          Список классов основного блока (через пробел)
 * 
 *}
 
{extends "component@bs-form.field"}

{component_define_params params=[ 'readonly']}

{block name="field_input"}
    <input {field_make_rules entity=$entity field=$name scenario=$scenario} type="{$typeRule|default:$type}" 
           class="{$component} {cmods name=$component mods=$bmods delimiter="-"} {$classes}" 
            {cattr list=$attributes} {if $readonly}readonly{/if}>
        
{/block}
    


