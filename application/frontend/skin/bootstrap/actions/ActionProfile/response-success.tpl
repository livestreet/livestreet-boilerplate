{**
 * Предложения
 *}
{extends 'layouts/layout.base.tpl'}

{block 'layout_content'}
    
    <h1>{lang "user.response_success.title" company=$oUserProfile->getName()} </h1>
    
    <p>{lang "user.response_success.text" pname=$oUserProfile->getName() url=$oUserProfile->getProfileUrl()} </p><br>
    <a href="{$oUserProfile->getProfileUrl()}">{$aLang.user.response_success.return}</a>

{/block}
