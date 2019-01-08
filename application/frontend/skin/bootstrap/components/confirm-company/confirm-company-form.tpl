{**
 * Текст
 *
 * @param string  $readonly          Список классов основного блока (через пробел)
 * 
 *}
 
{component_define_params params=[ ]}

<form action="" data-type="form-ajax" data-url="{router 'ajax/confirm-company'}" class="js-form-validate">
    
    <p>{$aLang.user.confirm_company.text}</p>
    
    {* Имя Фамилия *}
    {component 'bs-form' 
        template    = 'text' 
        name        = "name"
        placeholder = $aLang.auth.registration.form.fields.name.placeholder
        type        = "text"
        validateError = $aLang.user.confirm_company.form.validate.error_name
        attributes  = [
            required => true
        ]
        }
        
    {* E-mail *}
    {component 'bs-form' 
        template    = 'text' 
        name        = "mail"
        placeholder = $aLang.auth.registration.form.fields.email.placeholder
        type        = "email"
        validateError = $aLang.user.confirm_company.form.validate.error_email
        attributes  = [
            required => true
        ]}    
        
    {* Должность *}
    {component 'bs-form' 
        template    = 'text' 
        name        = "job"
        placeholder = $aLang.user.confirm_company.form.job.placeholder
        type        = "text"
        validateError = $aLang.user.confirm_company.form.validate.error_job
        attributes  = [
            required => true
        ]
        }
        
    {* Телефон *}
    {component 'bs-form' 
        template    = 'text' 
        name        = "phone"
        placeholder = $aLang.user.confirm_company.form.phone.placeholder
        type        = "text"
        validateError = $aLang.user.confirm_company.form.validate.error_phone
        attributes  = [
            required => true
        ]} 
        
    {* Сообщение *}
    {component 'bs-form' 
        template    = 'textarea' 
        name        = "mess"
        placeholder = $aLang.user.confirm_company.form.mess.placeholder
        validateError = $aLang.user.confirm_company.form.validate.error_mess
        attributes  = [
            required => true
        ]} 
    
    {if !$oUserCurrent}
        {component "recaptcha.field" 
            attributes  = [
                required => true
            ]
            validateError = $aLang.talk.response.notice.error_captcha
            name="recaptcha"}
    {/if}
    
     <input type="hidden" name="redirect" value="{$redirect}">
</form>

