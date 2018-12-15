{**
 * Загрузка медиа-файлов
 *}

{component "bs-modal" 
    classes     = "js-modal-media"
    header      = $aLang.media.title 
    bmods       = "lg" 
    centered    = true 
    content     = {component 'media' template='content'} 
    id          = "mediaModal"}
