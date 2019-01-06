{**
 * Текст
 *
 * @param string  $readonly          Список классов основного блока (через пробел)
 * 
 *}
 
{extends "component@bs-form.field"}

{component_define_params params=[ 'readonly']}

{block name="field_input"}
    <div id="g-recaptcha" class="g-recaptcha" data-sitekey="{Config::Get('module.validate.recaptcha.site_key')}"></div>
{/block}
    


