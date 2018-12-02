{**
 * Блок добавления поля
 *
 * @param boolean $item
 * @param integer $index
 * @param boolean $allowRemove
 * @param boolean $showRemove
 * @param boolean $isTemplate
 *}

{$component = 'ls-fieldset-item'}
{component_define_params params=[ 'name', 'id', 'value', 'allowRemove', 'showRemove', 'isTemplate' ]}

{$allowUpdate = $allowUpdate|default:true}
{$allowRemove = $allowRemove|default:true}
{$showRemove = $showRemove|default:true}
{$index = $index|default:0}


<li class="{$component} js-fieldset-item"
    {if $isTemplate}data-is-template="true"{/if}
    {if $isTemplate}style="display: none"{/if}>

    {* Текст *}
    {component 'field' template='text'
        name         = "{$name}[{$id}]"
        value        = $value
        isDisabled   = ! $allowUpdate
        inputClasses = 'ls-width-full js-fieldset-item-text'}

    {* Кнопка удаления *}
    {if $allowRemove}
        {component 'icon'
            icon='remove'
            classes="{$component}-remove js-fieldset-item-remove"
            attributes=[
                style => "{if ! $showRemove}display: none{/if}"
            ]}
    {/if}
</li>