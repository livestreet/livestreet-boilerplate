{**
 * Страница входа
 *}

{extends 'layouts/layout.base.tpl'}

{block 'layout_page_title'}
    {$aLang.auth.login.title}
{/block}

{block 'layout_content'}
    <div class="row justify-content-center">
        <div class="col-sm-6">
            {component 'auth' template='login' showExtra=true}
        </div>
    </div>
{/block}