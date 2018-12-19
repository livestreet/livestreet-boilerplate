{**
 * Текст
 *
 * @param string  $readonly          Список классов основного блока (через пробел)
 * 
 *}
 
{extends "component@bs-form.field"}

{component_define_params params=[ 'readonly']}

{block name="field_options"}
    {$attributesGroup = [
        'data-type' => 'media-field',
        'data-name' => {$name|default:"media[]"}
    ]}
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

