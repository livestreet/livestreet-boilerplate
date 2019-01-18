{**
 * Текст
 *
 * @param string  $readonly          Список классов основного блока (через пробел)
 * 
 *}
 
{extends "component@bs-form.field"}

{component_define_params params=[ 'multiple', 'dataCrop', 'crop', 'medias']}

{block name="field_options"}
    {if $crop}
        {$attributesGroup['data-cropped'] = null}
    {/if}
    
    {foreach $dataCrop as $key => $val}
        {$attributesGroup["data-crop-{$key}"] = $val}
    {/foreach}


    {$attributesGroup['data-type'] = 'media-field'}
    {$attributesGroup['data-name'] = "{$name|default:'media'}[]"}
    {$attributesGroup['data-multiple'] = {$multiple|default:"true"}}
{/block}





{block name="field_input"}
    
    {$mediaCount = 0}
    {if !$medias and $entity}
        {$medias = []}
        {$aMedias = $entity->getMedia()}
        {foreach $aMedias as $oMedia}
            {$medias[] = [obj => $oMedia]}
            {$mediaCount = $mediaCount + 1}
        {/foreach}
    {/if}   

    <input class="d-none" data-count name="{$name}_count" {cattr list=$validateRules} value="{$mediaCount}">
    
    {capture name="content"}
        

       
        {if is_array($medias)}
            {foreach $medias as $media}
                {component "bs-media.file" oMediaItem=$media.obj size=$media.size name=$name}
            {/foreach}
        {/if}
        
        {component 'bs-button' text=$text 
            classes="{if count($medias) and !$multiple}d-none{/if}" 
            attributes=["data-toggle"=>"modal", "data-target"=>"#mediaModal"]}    

    {/capture}
    {component "bs-card" content=[
        [   
            type => 'body',
            attributes => ['data-type' => 'field-body'],
            content => $smarty.capture.content
        ]
    ]}
    
        
{/block}

