{**
 * Предложение
 *}
 
{component_define_params params=[ 'entity', 'answered', 'targetUser', 'deleted', 'redirect']}

<div class="response mt-5">
    <div class="row">
        {if $targetUser}
            {$oUser = $entity->getTargetUser()}
        {else}
            {$oUser = $entity->getUser()}
        {/if}

        <div class="col-sm-3">{component "user" oUser=$oUser}</div>
        <div class="col-sm-9 ml-2 ml-sm-0">
            <div>{component "rating.stars" value=$entity->getRating()}</div>
            <div class="mt-2 text-muted">{$entity->getDateCreateFormat()}</div>
        </div>
    </div>
    <div class="row m-sm-3">
        <div class="col-12 pl-sm-5">
            {component "text" text=$entity->getText() classes="text-secondary"}
            
            {if is_array($entity->getMedia()) and count($entity->getMedia())}
                {$items = []}
                {foreach $entity->getMedia() as $oMedia}
                    {$items[] = [
                        href    => $oMedia->getFileWebPath(),
                        src     => $oMedia->getFileWebPath('x200crop')
                    ]}
                {/foreach}

                {component 'bs-carousel' classes="slide w-50" controls=true  items=$items}
            {/if}
            
            <div class="row mt-2">
                <div class="col-sm-8"></div>
                <div class="col-sm-4 align-content-end">
                    
                </div>
            </div>
            
            
            {foreach $entity->getAnswers(['target_type' => 'response', 'type' => 'arbitrage']) as $oArbitrage}
                {component "arbitrage" entity=$oArbitrage}
            {/foreach}

            
        </div>
    </div>
</div>
