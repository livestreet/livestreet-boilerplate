{**
 * Текст
 *
 * @param string  $readonly          Список классов основного блока (через пробел)
 * 
 *}
 
{extends "component@bs-form.field"}

{component_define_params params=[ 'readonly']}

{$id = "recaptcha{math equation='rand()'}"}
{block name="field_input"}
    <input {cattr list=$validateRules}  type="text" name="{$name}" style="display:none;"
        class=" {$component} {cmods name=$component mods=$bmods delimiter="-"} {$classes}" 
        {cattr list=$attributes} >
    <div id="g-recaptcha-{$attributes.id}" data-field-id="{$attributes.id}" class=" g-recaptcha" data-sitekey="{Config::Get('module.validate.recaptcha.site_key')}"></div>
{/block}
    


