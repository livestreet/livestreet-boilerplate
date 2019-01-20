{**
 * Текст
 *
 * @param string  $readonly          Список классов основного блока (через пробел)
 * 
 *}
 
{component_define_params params=[ 'oProposal', 'redirect']}

<form action="" data-form-ajax data-form-validate  data-url="{router page='ajax/talk/create-proposal'}">
    
    {$oProposal->_setValidateScenario('create')}
    
    {if !$oUserCurrent}
        
        {$oProposal->_setValidateScenario('create_anoname')}
        
        {* Имя анонима *}
        {component 'bs-form' 
            validate   = [
                entity => $oProposal
            ]
            template    = 'text' 
            name        = "user_name"
            value       = $oProposal->getUserName()
            placeholder = $aLang.talk.response.form.name.placeholder
            }
            
        {component "field.hidden" name="user_id" value="0"}
    {/if}
    {* Текст *}
    {component 'bs-form' 
        validate   = [
            entity => $oProposal
        ]
        template    = 'textarea' 
        name        = "text"
        label       = $aLang.talk.proposal.form.text.label
        placeholder = $aLang.talk.proposal.form.text.placeholder
        }
    {if $oUserCurrent}
        {component "bs-media.field" 
            validate   = [
                entity => $oProposal
            ]
            multiple = true
            name    = 'photos'
            label   = $aLang.talk.proposal.form.photo.label 
            text    = $aLang.talk.proposal.form.photo.text }
    {/if}
    
    {if !$oUserCurrent}
        {component "bs-form.recaptcha" 
            validate   = [
                entity => $oProposal
            ]
            name    = "recaptcha"}
    {/if}
    
    {if $oUserCurrent}
        {component "field.hidden" name="user_id" value="{$oUserCurrent->getId()}"}
    {/if}

    
    {component "field.hidden" name="target_id" value="{$oUserProfile->getId()}"}
    {component "field.hidden" name="target_type" value="user"}
    <input type="hidden" name="redirect" value="{$oUserProfile->getProfileUrl()}/proposals">
</form>

