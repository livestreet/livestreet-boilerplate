{**
 * Предложения
 *}
{extends 'layouts/layout.base.tpl'}

{block 'layout_content'}
    
    <h1>{lang "user.proposal_success.title" company=$oUserProfile->getName()} </h1>
    
    <p>{lang "user.proposal_success.text" name=$oUserProfile->getName() url=$oUserProfile->getProfileUrl()} </p><br>
    <a href="{$oUserProfile->getProfileUrl()}">{$aLang.user.proposal_success.return}</a>

{/block}
