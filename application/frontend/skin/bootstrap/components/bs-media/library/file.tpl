
{$component = 'bs-media-file'}
{component_define_params params=[  'oMediaItem' , 'attributes', 'classes', 'mods' ]}

{$attributes = array_merge( $attributes|default:[], [
    'data-param-user-id' => $iUserId,
    'data-type'     => "library"
])}

{capture name="sizes"}{strip}
    {$sizes = $oMediaItem->getDataOne('image_sizes')}
    {foreach $sizes as $size}
        {$size.w}x{$size.h|default:"..."}{if $size.crop}crop{/if}<br>
    {/foreach}
{/strip}{/capture}


<div class="{$component} d-inline-flex bg-light rounded m-2 p-2"  
        {if {$oMediaItem->getFileName()|count_characters} > 8}
            {component "bs-popover" content={$oMediaItem->getFileName()|escape} placement="bottom"}
        {/if}
        data-type="lib-file"
        data-id="{$oMediaItem->getId()}"
        data-media-type="{$oMediaItem->getType()}"
        data-date="{date_format date=$oMediaItem->getDateAdd() format='j F Y, H:i'}"
        data-media-title="{$oMediaItem->getDataOne('title')|escape}"
        data-name="{$oMediaItem->getFileName()|escape}"
        data-size="{$oMediaItem->getFileSize()}"
        data-media-width="{$oMediaItem->getWidth()}"
        data-media-height="{$oMediaItem->getHeight()}"
        data-dimensions="{$oMediaItem->getWidth()}x{$oMediaItem->getHeight()}"
        data-img="<img class='w-100' src='{$oMediaItem->getFileWebPath('200x')}'>"
        data-sizes="{$smarty.capture.sizes}">
    <div>
        <img src="{$oMediaItem->getFileWebPath('100crop')}" 
             alt="{$oMediaItem->getFileName()|escape}" 
             class=" w-100">
        <div class="{$component}-body mt-2">
          <h5 class="mt-0">{$oMediaItem->getFileName()|escape}</h5>
        </div>
    </div>
</div>