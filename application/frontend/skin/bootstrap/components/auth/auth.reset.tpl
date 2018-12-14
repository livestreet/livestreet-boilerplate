{**
 * Форма восстановления пароля
 *}

{component_define_params params=[ 'modal' ]}

<form action="{router page='auth'}password-reset/" method="post" class="mt-3 js-form-validate js-auth-reset-form">
    {* E-mail *}
    {component 'bs-form' 
        template    = 'text' 
        name        = "mail"
        placeholder = $aLang.auth.reset.form.fields.mail.label
        type        = "email"
        attributes  = [
            required => true
        ]}
        
    <div class="d-flex justify-content-center">
        {component 'bs-button' 
            classes = ""
            name='submit_reset' 
            type="submit" 
            bmods='primary' 
            text=$aLang.auth.reset.form.fields.submit.text}
    </div>
</form>