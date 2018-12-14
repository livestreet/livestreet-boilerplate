{**
 * Форма запроса повторной активации аккаунта
 *}

{extends 'layouts/layout.base.tpl'}

{block 'layout_page_title'}
    {$aLang.auth.reactivation.title}
{/block}

{block 'layout_content'}
    <div class="row justify-content-center">
        <div class="col-sm-6">
            {component 'auth' template='reactivation'}
        </div>
    </div>
{/block}