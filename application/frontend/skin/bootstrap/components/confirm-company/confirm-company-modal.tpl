{**
 * Загрузка медиа-файлов
 *}
 
{component_define_params params=[ ]}


{component "bs-modal" 
    header      = $aLang.user.confirm_company.form.title
    bmods       = $bmods|default:"lg" 
    showFooter  = true
    primaryButton = [
        bmods => "success",
        text => $aLang.talk.response.form.submit.text,
        attributes => ['data-modal-submit' => true]
    ]
    content     = {component 'confirm-company.form' }
    id          = "confirmModal" }
