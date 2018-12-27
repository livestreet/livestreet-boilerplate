{**
 * Текст
 *
 * @param string  $readonly          Список классов основного блока (через пробел)
 * 
 *}
 
{component_define_params params=[ 'oProposal']}

<form action="" data-type="form-ajax" data-url="{router page='ajax/talk/create-proposal'}" class="js-form-validate">
     
    {* Текст *}
    {component 'bs-form' 
        entity      = $oProposal
        template    = 'textarea' 
        name        = "text"
        label       = $aLang.talk.proposal.form.text.label
        placeholder = $aLang.talk.proposal.form.text.placeholder
        }
        
    {component "bs-media.field" 
        entity  = $oProposal
        multiple = true
        name    = 'photos[]'
        label   = $aLang.talk.proposal.form.photo.label 
        text    = $aLang.talk.proposal.form.photo.text }
        
    {component "field.hidden" name="user_id" value="{$oUserCurrent->getId()}"}
    {component "field.hidden" name="target_id" value="{$oUserProfile->getId()}"}
</form>

