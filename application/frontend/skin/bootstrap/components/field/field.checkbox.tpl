{**
 * Чекбокс
 *}

{extends 'component@field.field'}

{block 'field_options'}
    {component_define_params params=[ 'checked' ]}
    {$mods = "$mods checkbox"}
    {$getValueFromForm = false}

    {$smarty.block.parent}

    {$value = ( $value ) ? $value : '1'}
{/block}

{block 'field_input'}
    {if ! isset($checked) && $name && $form}
        {field_get_value form=$form name=$name assign=formValue}

        {if is_array($formValue)}
            {$checked = in_array($value, $formValue)}
        {else}
            {$checked = $value == $formValue}
        {/if}
    {/if}

    <input type="checkbox" {field_input_attr_common} {if $checked}checked{/if} />
{/block}