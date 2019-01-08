{**
 * Предложения
 *}
{extends 'layouts/layout.base.tpl'}

{block 'layout_content'}
    
    {component "bs-jumbotron" 
        title=$aLang.user.confirm_company.success_request.title 
        content=$aLang.user.confirm_company.success_request.text}

{/block}
