{**
 * Текст
 *
 * @param string  $readonly          Список классов основного блока (через пробел)
 * 
 *}
 
{component_define_params params=[ 'oResponse', 'redirect']}

<form action="" data-type="form-ajax" data-url="{router page='ajax/talk/create-response'}" class="js-form-validate">
    {component "rating.field-star" 
        entity  = $oResponse
        name    = "rating"
        count   = 5
        label   = $aLang.talk.response.form.stars.label
    }
    
        
    {* Текст *}
    {component 'bs-form' 
        entity      = $oResponse
        template    = 'textarea' 
        name        = "text"
        label       = $aLang.talk.response.form.text.label
        placeholder = $aLang.talk.response.form.text.placeholder
        }
        
    {component "bs-media.field" 
        entity  = $oResponse
        multiple = true
        name    = 'photos[]'
        label   = $aLang.talk.response.form.photo.label 
        text    = $aLang.talk.response.form.photo.text }
        
    {component "field.hidden" name="user_id" value="{$oUserCurrent->getId()}"}
    {component "field.hidden" name="target_id" value="{$oUserProfile->getId()}"}
    {component "field.hidden" name="target_type" value="user"}
     <input type="hidden" name="redirect" value="{$redirect}">
</form>

