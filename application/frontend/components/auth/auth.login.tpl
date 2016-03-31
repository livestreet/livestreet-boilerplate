{**
 * Форма входа
 *
 * @param string $redirectUrl
 *}

{$redirectUrl = $smarty.local.redirectUrl|default:$PATH_WEB_CURRENT}

{component_define_params params=[ 'modal' ]}

{hook run='login_begin'}

<form action="{router page='auth/login'}" method="post" class="js-form-validate js-auth-login-form{if $modal}-modal{/if}">
    {hook run='form_login_begin'}

    {* Логин *}
    {component 'field' template='text'
        name   = 'login'
        rules  = [ 'required' => true, 'minlength' => '3' ]
        label  = $aLang.auth.login.form.fields.login.label}

    {* Пароль *}
    {component 'field' template='text'
        name   = 'password'
        type   = 'password'
        rules  = [ 'required' => true, 'minlength' => '2' ]
        label  = $aLang.auth.labels.password}

    {* Запомнить *}
    {component 'field' template='checkbox'
        name    = 'remember'
        label   = $aLang.auth.login.form.fields.remember.label
        checked = true}

    {hook run='form_login_end'}

    {if $redirectUrl}
        {component 'field' template='hidden' name='return-path' value=$redirectUrl}
    {/if}

    {component 'button' name='submit_login' mods='primary' text=$aLang.auth.login.form.fields.submit.text}
</form>

{if $smarty.local.showExtra}
    <div class="pt-20">
        <a href="{router page='auth/register'}">{$aLang.auth.registration.title}</a><br />
        <a href="{router page='auth/password-reset'}">{$aLang.auth.reset.title}</a>
    </div>
{/if}

{hook run='login_end'}