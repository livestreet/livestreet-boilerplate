{**
 * Текст
 *
 * @param string  $readonly          Список классов основного блока (через пробел)
 * 
 *}
 
{component_define_params params=[ 'oArbitrage', 'target_id', 'target_type', 'redirect', 'url']}

<form action="" data-form-ajax data-form-validate  data-url="{$url}" class=" mb-3">
     
    {* Текст *}
    {component 'bs-form' 
        validate = [
            entity   => $oArbitrage
        ]
        template    = 'textarea' 
        name        = "text"
        placeholder = $aLang.talk.answer.form.text.placeholder
        label       = $aLang.talk.answer.form.text.label 
        }
        
    {component "bs-media.field" 
        validate = [
            entity   => $oArbitrage
        ]
        multiple = true
        name    = 'photos'
        label   = $aLang.talk.answer.form.photo.label 
        text    = $aLang.talk.answer.form.photo.text }
        
    {component "field.hidden" name="user_id" value="{$oUserCurrent->getId()}"}
    {component "field.hidden" name="target_id" value="{$target_id}"}
    {component "field.hidden" name="target_type" value="{$target_type}"}
    <input type="hidden" name="redirect" value="{$redirect}">
    
    {component "bs-button" text=$aLang.talk.answer.form.submit.text type="submit" bmods="primary"}
</form>

