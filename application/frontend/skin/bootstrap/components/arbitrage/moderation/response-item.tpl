{**
 * Предложение
 *}
 
{component_define_params params=[ 'entity', 'answered', 'targetUser', 'deleted', 'redirect']}

<div class="response-item" data-type="response-item" data-param-id="{$entity->getId()}" data-counter-selector="[data-count-moderation]">
    <hr>
    <div class="row mt-3">
        <div class="col-1"><a href="{router page="moderation/arbitrage-chat/{$entity->getId()}"}">{$entity->getId()}</a></div>
        <div class="col">{component "user" oUser=$entity->getUser()}</div>
        <div class="col d-none d-sm-block">{component "user" oUser=$entity->getTargetUser()}</div>
        <div class="col  d-none d-xl-block">{component "rating.stars" value=$entity->getRating()} {$entity->getDateCreateFormat()}</div>
        <div class="col-2 col-lg">

            {$idModal = "responseModal{$entity->getId()}"}

            {component "bs-nav" items = [
                
                [ 
                    'text' => "<span class='d-none d-lg-inline' >{$aLang.moderation.arbitrage.actions.publish}</span>", 
                    badge => {component 'bs-icon'  classes="text-success"  display="s" icon="check"},     
                    'url' => '#',  
                    'classes' => 'text-success py-0',
                    attributes => [
                        'data-param-id' => $entity->getId(),
                        'data-ajax-btn' => true,
                        'data-confirm'  => "true",
                        'data-confirm-message'  => $aLang.moderation.arbitrage.notice.confirm_publish,
                        'data-url'  => {router page="moderation/arbitrage/ajax-publish"},
                        'data-item-selector'  => '.response-item',
                        'data-counter-selector'  => '[data-count-arbitrage]'
                    ]
                ],
                [ 
                    'text' => "<span class='d-none d-lg-inline' >{$aLang.moderation.arbitrage.actions.delete}</span>", 
                    badge => {component 'bs-icon' classes="text-danger" icon="trash-alt"},  
                    'url' => {router page='/'},  
                    'classes' => 'text-danger pb-0' ,
                    attributes => [
                        'data-param-id' => $entity->getId(),
                        'data-ajax-btn' => true,
                        'data-confirm'  => "true",
                        'data-confirm-message'  => $aLang.moderation.arbitrage.notice.confirm_delete,
                        'data-url'  => {router page="moderation/arbitrage/ajax-delete"},
                        'data-item-selector'  => '.response-item',
                        'data-counter-selector'  => '[data-count-arbitrage]'
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

                {component 'bs-carousel' classes="slide w-25 mt-3" controls=true  items=$items}
            {/if}
        {/capture}

        
        {component "bs-text" classes=" border-left p-3" text=$smarty.capture.text}
        
        {component "arbitrage" entity=$entity->getArbitrage()}
    </div>
</div>
