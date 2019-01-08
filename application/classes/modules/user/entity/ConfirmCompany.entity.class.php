<?php

class ModuleUser_EntityConfirmCompany extends Entity
{
      
    public function __construct($aParam = false)
    {
       
        parent::__construct($aParam);
        
        $this->aValidateRules[] = array(
            'recaptcha',
            'captcha_recaptcha',
            'name'  => 'user_signup',
            'msg'   => $this->Lang_Get('talk.response.notice.error_captcha')
        );
        
        $this->aValidateRules[] = array(
            'job', 
            'string', 
            'allowEmpty' => false, 
            'min' => 5, 
            'max' => 100,
            'msg'   => $this->Lang_Get('user.confirm_company.form.validate.error_job')
        );
        $this->aValidateRules[] = [   
            'phone', 
            'number', 
            'min' => 9999999,
            'max' => 9999999999999,
            'allowEmpty' => false,
            'msg' => $this->Lang_Get('user.confirm_company.form.validate.error_phone')
        ];
        $this->aValidateRules[] = [
            'mail', 
            'email',
            'allowEmpty' => false, 
        ];
        $this->aValidateRules[] = [   
            'name', 
            'string', 
            'min' => 5, 
            'max' => 200, 
            'allowEmpty' => false,
        ];
        $this->aValidateRules[] = [   
            'company_name', 
            'string' 
        ];
        $this->aValidateRules[] = [   
            'company_url', 
            'string'
        ];
        $this->aValidateRules[] = [   
            'mess', 
            'string', 
            'min' => 10, 
            'max' => 2000, 
            'allowEmpty' => false
        ];
    }

}