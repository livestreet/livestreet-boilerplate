{**
 * Выбор файла
 *}

{extends 'component@field.field'}

{block 'field_options' append}
    {component_define_params params=[ 'uploadedFiles', 'removeName' ]}

    {$mods = "$mods file"}
{/block}

{block 'field_input'}
    <input type="file" {field_input_attr_common} />

    {if $uploadedFiles}
        <div class="{$component}-file-info">
            {block 'field_file_info'}
                <p>Загружен файл: <strong>{$uploadedFiles.name}.{$uploadedFiles.extension}</strong></p>
            {/block}

            <label>
                <input type="checkbox" name="{$removeName}" value="1"> {lang 'common.remove'}
            </label>
        </div>
    {/if}
{/block}