{**
 * Загрузка медиа-файлов
 *}
 
{component_define_params params=[ ]}



{component "bs-modal" 
    header      = $aLang.talk.proposal.modal.title
    bmods       = "lg" 
    showFooter  = true
    primaryButton = [
        bmods => "success",
        text => $aLang.talk.proposal.form.submit.text,
        attributes => ['data-modal-submit' => true]
    ]
    content     = {component 'proposal.form' 
                    oProposal=Engine::GetEntity('Talk_Proposal') 
                    redirect="{$oUserProfile->getProfileUrl()}/response-success"}
    id          = "proposalModal"}
