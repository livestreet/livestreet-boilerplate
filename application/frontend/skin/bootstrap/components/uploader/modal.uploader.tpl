{**
 * Загрузка медиа-файлов
 *}
{component "bs-modal" 
    classes     = "js-modal-media"
    header      = $aLang.media.title 
    bmods       = "lg" 
    centered    = true 
    content     = {component 'uploader' classes='js-uploader-modal' params=$uploader}
    id          = "mediaModal"}
{*extends 'Component@modal.modal'}

{block 'modal_options' append}
    {component_define_params params=[ 'uploader', 'choosable' ]}

    {$mods = "$mods uploader"}
    {$options = array_merge( $options|default:[], [ 'center' => 'false' ] )}
    {$content = {component 'uploader' classes='js-uploader-modal' params=$uploader}}

    {if $choosable|default:true}
        {$primaryButton = [
            'text' => {lang 'common.choose'},
            'classes' => 'js-uploader-modal-choose'
        ]}
    {/if}
{/block*}