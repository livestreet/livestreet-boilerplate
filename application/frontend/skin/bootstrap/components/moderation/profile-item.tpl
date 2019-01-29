{**
 * Предложение
 *}
 
{component_define_params params=[ 'oProfile', 'deleted']}

<div class="profile-item" >
    <hr>
    <div class="row mt-3">
        <div class="col-1">{$oProfile->getId()}</div>
        <div class="col">{component "user" oUser=$oProfile textWrap=true}</div>
        <div class="col-2 col-lg">

            {$idModal = "responseModal{$oProfile->getId()}"}

            {component "bs-nav" items = [
                [ 
                    text    => $aLang.moderation.profiles.actions.edit,  
                    url     => {router page="moderation/profile-edit/{$oProfile->getId()}"}
                ],
                
                [ 
                    'text' => $aLang.moderation.responses.actions.delete, 
                    icon => [ icon => "trash-alt", classes => "d-md-none text-danger d-inline"],
                    'url' => {router page='/'},  
                    'classes' => 'text-danger' ,
                    attributes => [
                        'data-param-id' => $oProfile->getId(),
                        'data-ajax-btn' => "true",
                        'data-confirm'  => "true",
                        'data-confirm-message'  => $aLang.moderation.responses.notice.confirm_delete,
                        'data-url'  => {router page="moderation/ajax-profile-delete"},
                        'data-item-selector'  => '.profile-item'
                    ]
                ]
            ]}


        </div>
    </div>
    <div class="collapse" id="responseCollapse">
        {capture name="text"}
            {$oProfile->getText()}
            {if is_array($oProfile->getMedia()) and count($oProfile->getMedia())}
                {$items = []}
                {foreach $oProfile->getMedia() as $oMedia}
                    {$items[] = [
                        href    => $oMedia->getFileWebPath(),
                        src     => $oMedia->getFileWebPath('x200crop')
                    ]}
                {/foreach}

                {component 'bs-carousel' classes="slide w-25" controls=true  items=$items}
            {/if}
        {/capture}

        
        {component "text" classes=" border-left p-3" text=$smarty.capture.text}
        
    </div>
   
</div>
