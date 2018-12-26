{**
 * Загрузка медиа-файлов
 *}
 
{component_define_params params=[ ]}

{capture name="content"}
    {*{component 'response-form' }*}
{/capture}


{component "bs-modal" 
    header      = $aLang.talk.propose.modal.title
    bmods       = "lg" 
    showFooter  = true
    primaryButton = [
        text => $aLang.common.save
    ]
    id          = "proposeModal"}
