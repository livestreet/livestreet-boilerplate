{**
 * Форма входа
 *
 * @param string $redirectUrl
 *}

{$redirectUrl = $smarty.local.redirectUrl|default:$PATH_WEB_CURRENT}


{hook run='login_begin'}
<form action="{router page='auth/login'}" method="post" name="register_user" class="js-form-validate js-auth-login-form mt-3">

    {hook run='form_login_begin'}
    {* Логин или Email*}
    {component 'bs-form' 
        template    = 'text' 
        name        = "mail_login"
        placeholder = $aLang.auth.login.form.fields.login_or_email.placeholder
        type        = "text"
        attributes  = [
            required => true
        ]}

    {* Пароль *}
    {component 'bs-form' template='text' 
        type        = "password"
        name        = "password"
        placeholder = $aLang.auth.login.form.fields.password.placeholder
        }

    {* Запомнить *}
    {component 'bs-form' template='checkbox'
        classes = "is-valid"
        name    = 'remember'
        label   = $aLang.auth.login.form.fields.remember.label
        checked = true}

    {hook run='form_login_end'}

    {if $redirectUrl}
        <input type="hidden"  class="ls-field-input is-valid" value="{$redirectUrl}" name="return-path" >      
    {/if}

    <div class="d-flex justify-content-center">
        {component 'bs-button' 
            classes = ""
            name='submit_login' 
            type="submit" 
            bmods='primary' 
            text=$aLang.auth.login.form.fields.submit.text}
    </div>
</form>
{hook run='login_end'}