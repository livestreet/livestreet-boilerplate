{**
 * Обрезка загруженного изображения
 *
 * @param string  $title
 * @param string  $desc
 * @param string  $image
 * @param integer $width
 * @param integer $height
 * @param integer $originalWidth
 * @param integer $originalHeight
 *}

{$component = 'ls-crop'}
{component_define_params params=[ 'title', 'mods', 'classes', 'attributes', 'crop' ]}


{component "bs-modal" 
    header          = $title|escape|default:{lang 'crop.title'} 
    centered        = true 
    content         = {component 'bs-crop' params=$crop}
    closed          = false
    showFooter      = true
    primaryButton  = [
        'text'    => {lang 'common.save'},
        'bmods' => "success"
    ]
    attributes      = ["data-type" => "crop-modal", "data-backdrop" => "false", "data-keyboard" => "false"]
    id              = "cropModal"}

