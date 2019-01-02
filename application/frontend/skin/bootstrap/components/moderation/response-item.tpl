{**
 * Предложение
 *}
 
{component_define_params params=[ 'entity', 'answered', 'targetUser', 'deleted', 'redirect']}

<div data-type="response-item" data-param-id="{$entity->getId()}" data-counter-selector="[data-count-moderation]">
    <hr>
    <div class="row mt-3">
        <div class="col-1">{$entity->getId()}</div>
        <div class="col">{component "user" oUser=$entity->getUser()}</div>
        <div class="col d-none d-sm-block">{component "user" oUser=$entity->getTargetUser()}</div>
        <div class="col  d-none d-xl-block">{component "rating.stars" value=$entity->getRating()} {$entity->getDateCreateFormat()}</div>
        <div class="col-2 col-lg">

            {$idModal = "responseModal{$entity->getId()}"}

            {component "bs-nav" items = [
                [ 
                    text    => "<span class='d-none d-lg-inline' >{$aLang.moderation.responses.actions.edit}</span>",  
                    badge   => {component 'bs-icon' icon="edit"},
                    url     => {router page='wiki/wikipdd'},  
                    attributes => ["data-toggle"=>"modal", "data-target"=>"#{$idModal}"],
                    classes => 'pt-0'
                ],
                [ 
                    'text' => "<span class='d-none d-lg-inline' >{$aLang.moderation.responses.actions.publish}</span>", 
                    badge => {component 'bs-icon'  classes="text-success"  display="s" icon="check"},     
                    'url' => {router page='blogs'},  
                    'classes' => 'text-success py-0',
                    attributes => ['data-btn-publish' => true]
                ],
                [ 
                    'text' => "<span class='d-none d-lg-inline' >{$aLang.moderation.responses.actions.delete}</span>", 
                    badge => {component 'bs-icon' classes="text-danger" icon="trash-alt"},  
                    'url' => {router page='/'},  
                    'classes' => 'text-danger pb-0' ,
                    attributes => ['data-btn-remove' => true]
                ]
            ]}

            {$smarty.capture.actions}


        </div>
    </div>
    <div class="collapse" id="responseCollapse">
        {component "text" classes=" border-left p-3" text=$entity->getText()}
    </div>
    {component "moderation.response-modal" 
        entity  = $entity 
        url     = {router page='ajax/talk/edit-response'} 
        title   = $aLang.talk.response.modal.title_edit 
        id      = $idModal}
</div>
