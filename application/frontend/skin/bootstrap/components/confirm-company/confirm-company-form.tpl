{**
 * Текст
 *
 * @param string  $readonly          Список классов основного блока (через пробел)
 * 
 *}
 
{component_define_params params=[ ]}

<form action="" data-form-ajax data-form-validate data-url="{router 'ajax/confirm-company'}" >
    
    <p>{$aLang.user.confirm_company.form.text}</p>
    
    {$oConfirm = Engine::GetEntity('User_ConfirmCompany')}
    
    {* Имя Фамилия *}
    {component 'bs-form' 
        template    = 'text' 
        name        = "name"
        placeholder = $aLang.auth.registration.form.fields.name.placeholder
        type        = "text"
        validate    = [
            entity => $oConfirm
        ]
        }
        
    {* E-mail *}
    {component 'bs-form' 
        template    = 'text' 
        name        = "mail"
        placeholder = $aLang.auth.registration.form.fields.email.placeholder
        type        = "email"
        validate    = [
            entity => $oConfirm
        ]}    
        
    {* Должность *}
    {component 'bs-form' 
        template    = 'text' 
        name        = "job"
        placeholder = $aLang.user.confirm_company.form.job.placeholder
        type        = "text"
        validate    = [
            entity => $oConfirm
        ]
        }
        
    {* Телефон *}
    {component 'bs-form' 
        template    = 'text' 
        name        = "phone"
        placeholder = $aLang.user.confirm_company.form.phone.placeholder
        type        = "text"
        validate    = [
            entity => $oConfirm
        ]} 
        
    {* Сообщение *}
    {component 'bs-form' 
        template    = 'textarea' 
        name        = "mess"
        placeholder = $aLang.user.confirm_company.form.mess.placeholder
        validate    = [
            entity => $oConfirm
        ]} 
        
    {component "field.hidden" name="company_name" value=$oUserProfile->getName()}
    {component "field.hidden" name="company_url" value=$oUserProfile->getProfileUrl()}
    
    {component "bs-form.recaptcha" 
        validate    = [
            entity => $oConfirm
        ]
        name="recaptcha"}
    
     <input type="hidden" name="redirect" value="{$redirect}">
</form>

