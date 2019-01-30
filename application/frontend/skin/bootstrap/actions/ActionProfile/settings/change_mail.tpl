{**
 * Сменить пароль
 *}
{extends 'layouts/layout.base.tpl'}

{block 'layout_page_title'}
    <h2>
        {$aLang.user.settings.change_mail.title}
    </h2>
{/block}

{block 'layout_content'}
    {capture name="form"}
        <form class="" method="POST" data-form-validate novalidate action="{$oUserProfile->getProfileUrl()}/settings/change_mail">
            
            {* Mail *}
            {component 'bs-form' 
                template    = 'text' 
                name        = "mail"
                label       = $aLang.user.settings.change_mail.form.mail.label
                placeholder = $aLang.user.settings.change_mail.form.mail.placeholder
                type        = "email"
                validate       = [ 
                    entity  => $oUserProfile
                ]}
                
            
            <div class="d-flex justify-content-center">
                {component 'bs-button' 
                    classes = ""
                    name='submit_mail' 
                    type="submit" 
                    bmods='primary' 
                    text=$aLang.common.save}
            </div>
        </form>
    {/capture}
    
    {component 'bs-card' bg="light" content=[
        
        [   
            type => 'body',
            content => $smarty.capture.form
        ]
    ]}
    
{/block}