{**
 * Загрузка медиа-файлов
 *}
 
{component_define_params params=[ 'uploader' ]}

{capture name="content"}
    {component 'bs-media' uploader=$uploader}
{/capture}


{component "bs-modal" 
    params      = $params
    classes     = "js-modal-media"
    header      = $aLang.media.title 
    bmods       = "lg" 
    content     = $smarty.capture.content
    showFooter  = true
    primaryButton = [
        text => $aLang.media.library.primaryButton
    ]
    id          = "mediaModal"}
