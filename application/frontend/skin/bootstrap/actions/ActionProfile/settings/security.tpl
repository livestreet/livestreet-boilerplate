{**
 * Сменить пароль
 *}
{extends 'layouts/layout.base.tpl'}

{block 'layout_page_title'}
    <h2>
        {$aLang.user.settings.security.title}
    </h2>
{/block}

{block 'layout_content'}
    {capture name="form"}
        <form class=""  data-form-ajax data-form-validate novalidate data-url='{router "{$oUserProfile->getLogin()}/settings/security-ajax"}'>
            
            {* Password *}
            {component 'bs-form' 
                template    = 'text' 
                name        = "password"
                label       = $aLang.user.settings.security.form.password.placeholder
                type        = "password"
                validate       = [ 
                    entity  => $oUserProfile
                ]}
                
            {* password_new *}
            {component 'bs-form' 
                template    = 'text' 
                name        = "password_new"
                label       = $aLang.user.settings.security.form.password_new.placeholder
                type        = "password"
                validate       = [ 
                    entity  => $oUserProfile,
                    field   => 'password'
                ]}
                
            {* password_confirm *}
            {component 'bs-form' 
                template    = 'text' 
                name        = "password_confirm"
                label       = $aLang.user.settings.security.form.password_confirm.placeholder
                type        = "password"
                validate       = [ 
                    entity  => $oUserProfile,
                    field   => 'password'
                ]}
            <div class="d-flex justify-content-center">
                {component 'bs-button' 
                    classes = ""
                    name='submit_settings' 
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