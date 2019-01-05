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

{$component = 'bs-crop'}
{component_define_params params=[ 'desc', 'image', 'originalWidth', 'originalHeight', 'width', 'height', 'title', 'mods', 'classes', 'attributes' ]}

{if $originalWidth}
    {$attributes["data-crop-width"] = $originalWidth}
{/if}
{if $originalHeight}
    {$attributes["data-crop-height"] = $originalHeight}
{/if}

{if $width}
    {$attributes["width"] = $width}
{/if}
{if $height}
    {$attributes["height"] = $height}
{/if}

{block 'crop_modal_options'}{/block}
{$desc = $desc|escape}

{if $desc}
    <p class="{$component}-desc">{$desc}</p>
{/if}

<img src="{$image|escape}?v{mt_rand()}"
     class="{$component}-image js-crop w-100" data-type="crop"  {cattr list=$attributes}>

