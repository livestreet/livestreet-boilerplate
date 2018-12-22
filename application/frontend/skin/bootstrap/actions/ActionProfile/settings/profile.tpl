{**
 * Тестовая страница
 *}
{extends 'layouts/layout.base.tpl'}

{block 'layout_content'}
    {capture name="form"}
        <form class="" data-type="form-ajax" data-url="{$oUserProfile->getProfileUrl()}/settings/profile-ajax">
            {* Фото*}
            
            {$medias = []}
            {$aMedias = $oUserProfile->getMedia('user_photo')}
            {foreach $aMedias as $oMedia}
                {$medias[] = [obj => $oMedia, size => 'photo']}
            {/foreach}

            {component "bs-media.field" 
                medias  = $medias
                crop    = true
                dataCrop  = [
                    'aspect-ratio' => '1'
                ]
                multiple = false
                name    = 'photo'
                label   = $aLang.user.settings.profile.form.photo.label 
                text    = $aLang.user.settings.profile.form.photo.text         }
                
            {* Имя Фамилия *}
            {component 'bs-form' 
                template    = 'text' 
                name        = "name"
                label       = $aLang.user.settings.profile.form.name.label
                placeholder = $aLang.user.settings.profile.form.name.placeholder
                type        = "text"
                value       = $oUserProfile->getName()
                }
                
            {* О себе *}
            {component 'bs-form' 
                template    = 'textarea' 
                name        = "about"
                label       = $aLang.user.settings.profile.form.about.label
                placeholder = $aLang.user.settings.profile.form.about.placeholder
                value       = $oUserProfile->getAbout()
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

{block "layout_modals" append}
    {component "bs-crop.modal"}
    
{/block}