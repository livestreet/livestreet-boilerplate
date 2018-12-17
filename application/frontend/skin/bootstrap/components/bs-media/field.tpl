{**
 * Текст
 *
 * @param string  $readonly          Список классов основного блока (через пробел)
 * 
 *}
 
{extends "component@bs-form.field"}

{component_define_params params=[ 'readonly']}

{block name="field_input"}
    {component "bs-card" content=[
        [   
            type => 'body',
            attributes => ['data-type' => 'field-body'],
            content => {component 'bs-button' text=$text attributes=["data-toggle"=>"modal", "data-target"=>"#mediaModal"]}
        ]
    ]}
    <input {field_make_rules entity=$entity field=$name } type="hidden" 
           class="{$component} d-none {cmods name=$component mods=$bmods delimiter="-"} {$classes}" 
            {cattr list=$attributes}>
        
{/block}

