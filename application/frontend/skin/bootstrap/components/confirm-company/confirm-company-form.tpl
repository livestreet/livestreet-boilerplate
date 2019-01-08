{**
 * Текст
 *
 * @param string  $readonly          Список классов основного блока (через пробел)
 * 
 *}
 
{component_define_params params=[ ]}

<form action="" data-type="form-ajax" data-url="{router 'ajax/confirm-company'}" class="js-form-validate">
    
    <p>{$aLang.user.confirm_company.form.text}</p>
    
    {* Имя Фамилия *}
    {component 'bs-form' 
        template    = 'text' 
        name        = "name"
        placeholder = $aLang.auth.registration.form.fields.name.placeholder
        type        = "text"
        entity      = "User_ConfirmCompany"
        }
        
    {* E-mail *}
    {component 'bs-form' 
        template    = 'text' 
        name        = "mail"
        placeholder = $aLang.auth.registration.form.fields.email.placeholder
        type        = "email"
        entity      = "User_ConfirmCompany"}    
        
    {* Должность *}
    {component 'bs-form' 
        template    = 'text' 
        name        = "job"
        placeholder = $aLang.user.confirm_company.form.job.placeholder
        type        = "text"
        entity      = "User_ConfirmCompany"
        }
        
    {* Телефон *}
    {component 'bs-form' 
        template    = 'text' 
        name        = "phone"
        placeholder = $aLang.user.confirm_company.form.phone.placeholder
        type        = "text"
        entity      = "User_ConfirmCompany"} 
        
    {* Сообщение *}
    {component 'bs-form' 
        template    = 'textarea' 
        name        = "mess"
        placeholder = $aLang.user.confirm_company.form.mess.placeholder
        entity      = "User_ConfirmCompany"} 
        
    {component "field.hidden" name="company_name" value=$oUserProfile->getName()}
    {component "field.hidden" name="company_url" value=$oUserProfile->getProfileUrl()}
    
    {component "recaptcha.field" 
        entity      = "User_ConfirmCompany"
        name="recaptcha"}
    
     <input type="hidden" name="redirect" value="{$redirect}">
</form>

