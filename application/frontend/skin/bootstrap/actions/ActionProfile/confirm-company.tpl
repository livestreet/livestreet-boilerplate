{**
 * Предложения
 *}
{extends 'layouts/layout.base.tpl'}

{block 'layout_content'}
    
    <h1>{lang "user.confirm_company.success_request.title" company=$oUserProfile->getName()} </h1>
    
    <p>{$aLang.user.confirm_company.success_request.text} </p><br>
    <a href="{$oUserProfile->getProfileUrl()}">{$aLang.user.confirm_company.success_request.return}</a>

{/block}
