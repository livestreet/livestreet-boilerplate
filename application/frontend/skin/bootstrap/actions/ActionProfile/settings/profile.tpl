{**
 * Тестовая страница
 *}
{extends 'layouts/layout.base.tpl'}

{block 'layout_content'}
    {capture name="form"}
        <form class="">
            {component "bs-button" text="Modal" bmods="success" attributes=["data-toggle"=>"modal", "data-target"=>"#mediaModal"]}
            {* Имя Фамилия *}
            {component 'bs-form' 
                template    = 'text' 
                name        = "name"
                label       = $aLang.user.settings.profile.form.name.label
                placeholder = $aLang.user.settings.profile.form.name.placeholder
                type        = "text"
                value       = $oUserCurrent->getName()
                }
                
            {* О себе *}
            {component 'bs-form' 
                template    = 'textarea' 
                name        = "about"
                label       = $aLang.user.settings.profile.form.about.label
                placeholder = $aLang.user.settings.profile.form.about.placeholder
                value       = $oUserCurrent->getAbout()
                }

            <div class="d-flex justify-content-center">
                {component 'bs-button' 
                    classes = ""
                    name='submit_settings' 
                    type="submit" 
                    bmods='primary' 
                    text=$aLang.common.save}
            </div>
        </form>
    {/capture}
    
    {component 'bs-card' bg="light" content=[
        
        [   
            type => 'body',
            content => $smarty.capture.form
        ]
    ]}
    
{/block}