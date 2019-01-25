{**
 * Предложение
 *}
 
{component_define_params params=[ 'entity', 'answered', 'targetUser', 'deleted', 'redirect']}

<div class="response-item" data-type="response-item" data-param-id="{$entity->getId()}" data-counter-selector="[data-count-moderation]">
    <hr>
    <div class="row mt-3">
        <div class="col-1">{$entity->getId()}</div>
        <div class="col">{component "user" oUser=$entity->getUser() textWrap=true}</div>
        <div class="col d-none d-sm-block">{component "user" oUser=$entity->getTargetUser() textWrap=true}</div>
        <div class="col  d-none d-xl-block">{component "rating.stars" value=$entity->getRating()} {$entity->getDateCreateFormat()}</div>
        <div class="col-2 col-lg">

            {$idModal = "responseModal{$entity->getId()}"}

            {component "bs-nav" classes="flex-column" items = [
                [ 
                    text    => "<span class='d-none d-md-inline' >{$aLang.moderation.responses.actions.edit}</span>",  
                    icon   => [ icon => "edit", classes => "d-md-none d-inline"],
                    url     => {router page='wiki/wikipdd'},  
                    attributes => ["data-toggle"=>"modal", "data-target"=>"#{$idModal}"],
                    classes => 'py-0'
                ],
                [ 
                    'text' => "<span class='d-none d-md-inline' >{$aLang.moderation.responses.actions.publish}</span>", 
                    icon => [ icon => "check", display => "s", classes => "d-md-none text-success d-inline"],
                    'url' => {router page='blogs'},  
                    'classes' => 'text-success py-0',
                    enable  => ( !$entity->isPublish() ),
                    attributes => [
                        'data-param-id' => $entity->getId(),
                        'data-ajax-btn' => "true",
                        'data-confirm'  => "true",
                        'data-confirm-message'  => $aLang.moderation.responses.notice.confirm_publish,
                        'data-url'  => {router page="moderation/ajax-publish"},
                        'data-item-selector'  => '.response-item'
                    ]
                ],
                [ 
                    'text' => "<span class='d-none d-md-inline' >{$aLang.moderation.responses.actions.delete}</span>", 
                    icon => [ icon => "trash-alt", classes => "d-md-none text-danger d-inline"],
                    'url' => {router page='/'},  
                    'classes' => 'text-danger py-0' ,
                    attributes => [
                        'data-param-id' => $entity->getId(),
                        'data-ajax-btn' => "true",
                        'data-confirm'  => "true",
                        'data-confirm-message'  => $aLang.moderation.responses.notice.confirm_delete,
                        'data-url'  => {router page="moderation/ajax-delete"},
                        'data-item-selector'  => '.response-item'
                    ]
                ]
            ]}

            {$smarty.capture.actions}


        </div>
    </div>
    <div class="collapse" id="responseCollapse">
        {capture name="text"}
            {$entity->getText()}
            {if is_array($entity->getMedia()) and count($entity->getMedia())}
                {$items = []}
                {foreach $entity->getMedia() as $oMedia}
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
    {component "moderation.response-modal" 
        entity  = $entity 
        url     = {router page='ajax/talk/edit-response'} 
        title   = $aLang.talk.response.modal.title_edit 
        id      = $idModal}
</div>
