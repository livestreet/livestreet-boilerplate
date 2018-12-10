{**
 * Форма регистрации
 *
 * @param string $redirectUrl
 *}

{$redirectUrl = $smarty.local.redirectUrl|default:$PATH_WEB_CURRENT}

{component_define_params params=[ 'modal' ]}

{hook run='registration_begin'}

<form action="{router page='auth/register'}" method="post" class="js-form-validate js-auth-registration-form">
    {hook run='form_registration_begin'}

    {component "bs-tabs" bmods = 'pills primary' classes="mt-3 mb-3 d-flex justify-content-center" items = [
        [ text => 'Личность', content => {component 'auth.fields-user'}, active => true ],
        [ text => 'Компания', content => {component 'auth.fields-company'}]
    ]}
    
    
    
    {* Каптча *}
    {component 'field' template='captcha-recaptcha'
        captchaType        = Config::Get('general.captcha.type')
        name        = 'captcha'
        captchaName = 'user_signup'
        label       = $aLang.auth.labels.captcha}

    {hook run='form_registration_end'}

    {if $redirectUrl}
        {component 'field' template='hidden' name='return-path' value=$redirectUrl}
    {/if}

    <div class="d-flex justify-content-center">
        {component 'bs-button' 
            classes = ""
            name='submit_register' 
            type="submit" 
            bmods='primary' 
            text=$aLang.auth.registration.form.fields.submit.text}
    </div>
</form>

{hook run='registration_end'}
