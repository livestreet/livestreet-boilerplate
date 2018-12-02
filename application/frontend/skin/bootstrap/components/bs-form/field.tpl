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
{component_define_params params=[ 'bmods', 'bg', 'classes', 'attributes', 'name', 'id', 'label', 'placeholder', 'desc', 'value', 'type',
    'classesGroup', 'readonly', 'classesLabel', 'classesDesc', 'required', 'validateError', 'validateSuccess', 'custom', 'size']}

{if $custom}
    {$component = "custom-control"}
{/if}

{if $size}
    {$classes ="{$classes} form-control-{$size}"}
    {$classesLabel="{$classesLabel} form-control-{$size}"}
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
    {if $validateError}
        <div class="invalid-feedback">
            {$validateError}
        </div>
    {/if}
    {if $validateSuccess}
        <div class="valid-feedback">
            {$validateSuccess}
        </div>
    {/if}
{/capture}

{block name="out_content"}
    {component "bs-form.group" 
        custom=$custom 
        classes=$classesGroup 
        bmods=$bmodsGroup 
        type=$type 
        componentGroup=$componentGroup 
        content=$smarty.capture.content}
{/block}
