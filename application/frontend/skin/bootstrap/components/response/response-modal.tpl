{**
 * Загрузка медиа-файлов
 *}
 
{component_define_params params=[ ]}


{component "bs-modal" 
    header      = $aLang.talk.response.modal.title
    bmods       = "lg" 
    showFooter  = true
    primaryButton = [
        bmods => "success",
        text => $aLang.talk.response.form.submit.text,
        attributes => ['data-modal-submit' => true]
    ]
    content     = {component 'response.form' oResponse=Engine::GetEntity('Talk_Response')}
    id          = "responseModal"}
