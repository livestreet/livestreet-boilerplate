{**
 * Текст
 *
 * @param string  $readonly          Список классов основного блока (через пробел)
 * 
 *}
 
{component_define_params params=[ 'oResponse', 'redirect', 'url']}

<form action="" data-form-ajax data-form-validate  data-url="{$url}" novalidate>
    {$oResponse->_setValidateScenario('create')}
    
    {if !$oUserCurrent}
        {$oResponse->_setValidateScenario('create_anoname')}
        
        {* Имя анонима *}
        {component 'bs-form' 
            template    = 'text' 
            name        = "user_name"
            value       = $oResponse->getUserName()
            placeholder = $aLang.talk.response.form.name.placeholder
            validate   = [
                entity => $oResponse
            ]
            }
            
        {component "field.hidden" name="user_id" value="0"}
    {/if}

    
    
    {component "rating.field-star" 
        name    = "rating"
        value   = $oResponse->getRating()
        count   = 5
        label   = $aLang.talk.response.form.stars.label
        validate   = [
            entity => $oResponse
        ]
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
    {if $oUserCurrent}
        {component "bs-media.field" 
            validate   = [
                entity => $oResponse
            ]
            multiple = true
            name    = 'photos'
            label   = $aLang.talk.response.form.photo.label 
            text    = $aLang.talk.response.form.photo.text }
    {/if}
    
    {if !$oUserCurrent}
        {component "bs-form.recaptcha" 
            validate   = [
                entity => $oResponse
            ]
            name="recaptcha"}
    {/if}
        
    {if $oResponse->getId()}
        {component "field.hidden" name="id" value="{$oResponse->getId()}"}
    {else}
        {if $oUserCurrent}
            {component "field.hidden" name="user_id" value="{$oUserCurrent->getId()}"}
        {/if}
        
        {component "field.hidden" name="target_id" value="{$oUserProfile->getId()}"}
        {component "field.hidden" name="target_type" value="user"}
    {/if} 

    
     <input type="hidden" name="redirect" value="{$redirect}">
</form>

