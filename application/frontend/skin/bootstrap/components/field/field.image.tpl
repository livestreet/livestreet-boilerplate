{**
 * Выбор файла
 *}

{extends 'component@field.file'}

{block 'field_file_info'}
    <p>
        {foreach $uploadedFiles as $image}
            <img src="{$image}" alt="">
        {/foreach}
    </p>
{/block}