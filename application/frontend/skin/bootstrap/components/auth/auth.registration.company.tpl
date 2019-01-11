
<form action="{router page='auth/register'}" method="post" name="register_company" class="js-form-validate js-auth-registration-form js-recaptcha-form" novalidate>
    
    {hook run='form_registration_begin'}
    {* E-mail *}
    {component 'bs-form' 
        template    = 'text' 
        name        = "mail"
        placeholder = $aLang.auth.registration.form.fields.email.placeholder
        type        = "email"
        attributes  = [
            required => true,
            remote => "{router page='auth'}ajax-validate-email"
        ]}

    {* Имя Фамилия *}
    {component 'bs-form' 
        template    = 'text' 
        name        = "name"
        placeholder = $aLang.auth.registration.form.fields.name_company.placeholder
        type        = "text"
        entity      = 'User_User'
        }

    {* Логин *}
    {component 'bs-form' 
        template    = 'text' 
        name        = "login"
        placeholder = $aLang.auth.registration.form.fields.login.placeholder
        type        = "text"
        desc        = $aLang.auth.registration.form.fields.login.desc  
        attributes       = [ 
            required => true,
            remote => "{router page='auth'}ajax-validate-login"
        ]}

    {* Пароль *}
    {component 'bs-form' template='text' 
        type        = "password"
        name        = "password"
        placeholder = $aLang.auth.registration.form.fields.password.placeholder
        entity      = 'User_User'
        validate       = [ 
            triggers => 'change keyup'
        ]}
        
    {if Config::Get('module.user.captcha_use_registration')}
        {component "recaptcha.field" 
            entity      = 'User_User'
            name        = "recaptcha"}
    {/if}



    {hook run='form_registration_end'}

    {if $redirectUrl}
        <input type="hidden"  class="ls-field-input is-valid" value="{$redirectUrl}" name="return-path" >        
    {/if}
    
    <input type="hidden"  class="ls-field-input is-valid" value="company" name="role" >

    <div class="d-flex justify-content-center">
        {component 'bs-button' 
            classes = ""
            name='submit_register' 
            type="submit" 
            bmods='primary' 
            text=$aLang.auth.registration.form.fields.submit.text}
    </div>
</form>