{**
 * Текст
 *
 * @param string  $readonly          Список классов основного блока (через пробел)
 * 
 *}
{component_define_params params=[ 'oArbitrage', 'target_id', 'target_type', 'redirect']}

<form action="" data-form-ajax  data-form-validate data-url="{router page='ajax/talk/create-arbitrage'}" class="mb-3">
     
    {$oArbitrage->_setValidateScenario('create')}
    {* Текст *}
    {component 'bs-form' 
        validate = [
            entity   => $oArbitrage
        ]
        template    = 'textarea' 
        name        = "text"
        placeholder = $aLang.talk.arbitrage.form.text.placeholder
        label       = $aLang.talk.arbitrage.form.text.label 
        }

    {component "bs-media.field" 
        validate = [
            entity   => $oArbitrage
        ]
        multiple = true
        name    = 'photos'
        label   = $aLang.talk.arbitrage.form.photo.label 
        text    = $aLang.talk.arbitrage.form.photo.text }
        
    {component "field.hidden" name="user_id" value="{$oUserCurrent->getId()}"}
    {component "field.hidden" name="target_id" value="{$target_id}"}
    {component "field.hidden" name="target_type" value="{$target_type}"}
    <input type="hidden" name="redirect" value="{$redirect}">
    
    {component "bs-button" text=$aLang.talk.arbitrage.form.submit.text type="submit" bmods="primary"}
</form>

