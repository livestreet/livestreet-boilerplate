{**
 * Форма запроса повторной активации аккаунта
 *}

<form action="{router page='auth'}reactivation/" method="post" class="js-form-reactivation">
    {* E-mail *}
    {component 'bs-form' 
        template    = 'text' 
        name        = "mail"
        placeholder = $aLang.auth.reactivation.form.fields.mail.label
        type        = "email"
        attributes  = [
            required => true
        ]}
        
    <div class="d-flex justify-content-center">
        {component 'bs-button' 
            classes = ""
            name='submit_reactivation' 
            type="submit" 
            bmods='primary' 
            text=$aLang.auth.reactivation.form.fields.submit.text}
    </div>

</form>