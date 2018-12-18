{**
 * Форма
 *
 * @param string  $name             Имя
 * @param string  $id               Идентификатор
 * @param string  $placeholder      По умолчанию
 * @param string  $desc             Описание
 * @param string  $value            Значение
 * @param string  $label            Метка
 * @param string  $bmods="success"  Список модификторов основного блока (через пробел)
 * @param string  $bg="light"       Модификтор фона
 * @param string  $classes          Список классов основного блока (через пробел)
 * @param array   $attributes       Список атрибутов основного блока
 * 
 *}

{$component = "form-control"}
{component_define_params params=[ 'bmods', 'bg', 'classes', 'popover', 'attributes', 'name', 'id', 'label', 'placeholder', 'desc', 'value', 'type',
    'classesGroup', 'attributesGroup', 'readonly', 'classesLabel', 'classesDesc', 'required', 'validateError', 'validateSuccess', 'custom', 'size']}

{if $custom}
    {$component = "custom-control"}
{/if}

{if $size}
    {$classes ="{$classes} form-control-{$size}"}
    {$classesLabel="{$classesLabel} form-control-{$size}"}
{/if}

{if ! $attributes.triggers}
    {$attributes.triggers = "change keyup"}
{/if}



{if $placeholder}
    {$attributes.placeholder = $placeholder}
{/if}
{if $name}
    {$attributes.name = $name}
{/if}
{if $required}
    {$attributes.required = true}
{/if}
{if !$id}
    {$attributes.id = "field{math equation='rand()'}"}
{else}
    {$attributes.id = $id}
{/if}
{$attributes["aria-describedby"] = "{$attributes.id}Help"}
{if $value}
    {$attributes.value = $value}
{/if}

{block name="field_options"}{/block}  

{capture name="content"}
    {block name="field_content"}
        {if $label}
            <label for="{$attributes.id} {$classesLabel}">{$label}</label>
        {/if}
        {block name="field_input"}{/block}
        {if $desc}
            <small id="{$attributes.id}Help" class="form-text text-muted {$classesDesc}">{$desc}</small>
        {/if}
    {/block}
    <div class="invalid-feedback">
        {$msg|default:$messageError}       
    </div>
    <div class="valid-feedback">
        {$messageSuccess}
    </div>
{/capture}

{block name="out_content"}
    {component "bs-form.group" 
        popover=$popover
        custom=$custom 
        classes=$classesGroup 
        bmods=$bmodsGroup 
        type=$type 
        attributes = $attributesGroup
        componentGroup=$componentGroup 
        content=$smarty.capture.content}
{/block}
