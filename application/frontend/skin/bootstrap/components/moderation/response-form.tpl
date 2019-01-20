{**
 * Текст
 *
 * @param string  $readonly          Список классов основного блока (через пробел)
 * 
 *}
 
{component_define_params params=[ 'oResponse', 'redirect', 'url']}

<form action="" data-form-ajax data-form-validate data-url="{$url}">
    
    {$oResponse->_setValidateScenario('create')}
    {component "bs-form.text" 
        validate   = [
            entity => $oResponse
        ]
        name    = "rating"
        value   = $oResponse->getRating()
        label   = $aLang.talk.response.form.stars.label
    }
    
    {* Текст *}
    {component 'bs-form' 
        validate   = [
            entity => $oResponse
        ]
        template    = 'textarea' 
        name        = "text"
        value       = $oResponse->getText()
        label       = $aLang.talk.response.form.text.label
        placeholder = $aLang.talk.response.form.text.placeholder
        }
        
    {component "bs-media.field" 
        validate   = [
            entity => $oResponse
        ]
        multiple = true
        name    = 'photos'
        label   = $aLang.talk.response.form.photo.label 
        text    = $aLang.talk.response.form.photo.text }
        
    {if $oResponse->getId()}
        {component "field.hidden" name="id" value="{$oResponse->getId()}"}
    {else}
        {component "field.hidden" name="user_id" value="{$oUserCurrent->getId()}"}
        {component "field.hidden" name="target_id" value="{$oUserProfile->getId()}"}
        {component "field.hidden" name="target_type" value="user"}
    {/if} 

    
</form>

