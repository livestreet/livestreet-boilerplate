{**
 * Drag & drop загрузка
 *}

{$component = 'bs-field-upload-area'}
{component_define_params params=[ 'isMultiple', 'inputAttributes', 'inputClasses', 'inputName', 'label', 'mods', 'classes', 'attributes' ]}

{$attributes['data-type'] = 'upload-area'}

<label class="{$component} {cmods name=$component mods=$mods} {$classes}" {cattr list=$attributes}>
    <span>{$label|default:{lang name='field.upload_area.label'}}</span>
    <input type="file" name="{$name|default:'file'}" class="{$inputClasses}" 
           data-type="file-input"  {$isMultiple|default:'multiple'}>
</label>