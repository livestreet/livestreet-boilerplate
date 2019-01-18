
{$component = 'bs-media-file'}
{component_define_params params=[  'oMediaItem' , 'attributes', 'classes', 'mods', 'size', 'name' ]}

{$attributes = array_merge( $attributes|default:[], [
    'data-param-user-id' => $iUserId,
    'data-type'     => "library"
])}

{if !$size}
    {$size = '100crop'}
{/if}



<div class="{$component} d-inline-flex bg-light rounded m-2 p-2 position-relative"  
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
        data-width="{$oMediaItem->getWidth()}"
        data-height="{$oMediaItem->getHeight()}"
        data-dimensions="{$oMediaItem->getWidth()}x{$oMediaItem->getHeight()}"
        data-img="<img class='w-100' src='{$oMediaItem->getFileWebPath('200x')}'>"
        data-src="{$oMediaItem->getFileWebPath()}"
        data-count-targets="{$oMediaItem->getCountTargets()}"
        data-media-sizes='{json var=$oMediaItem->getDataOne('image_sizes')}' >
    
    <div>
        <img src="{$oMediaItem->getFileWebPath($size)}" 
             alt="{$oMediaItem->getFileName()|escape}" 
             class=" w-100" data-img>
        <div class="{$component}-body mt-2">
          <h5 class="mt-0">{$oMediaItem->getFileName()|escape}</h5>
        </div>
    </div>
    {if $name}
          <input type="hidden" data-file-id="{$oMediaItem->getId()}" name="{$name}[]" value="{$oMediaItem->getId()}">
    {/if}
   
    <button type="button" class="close position-absolute text-danger d-none" style="right:.5rem;" aria-label="Close">
        <span aria-hidden="true">×</span>
    </button>
</div>