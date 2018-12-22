{**
 * Текст
 *
 * @param string  $readonly          Список классов основного блока (через пробел)
 * 
 *}
 
{extends "component@bs-form.field"}

{component_define_params params=[ 'multiple', 'dataCrop', 'crop']}

{block name="field_options"}
    {if $crop}
        {$attributesGroup['data-cropped'] = null}
    {/if}
    
    {foreach $dataCrop as $key => $val}
        {$attributesGroup["data-crop-{$key}"] = $val}
    {/foreach}


    {$attributesGroup['data-type'] = 'media-field'}
    {$attributesGroup['data-name'] = {$name|default:"media[]"}}
    {$attributesGroup['data-multiple'] = {$multiple|default:"true"}}
{/block}


{block name="field_input"}
    {component "bs-card" content=[
        [   
            type => 'body',
            attributes => ['data-type' => 'field-body'],
            content => {component 'bs-button' text=$text attributes=["data-toggle"=>"modal", "data-target"=>"#mediaModal"]}
        ]
    ]}
    
        
{/block}

