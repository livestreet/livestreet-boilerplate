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

        <div class="col-sm-4">{component "user" oUser=$oUser}</div>
        <div class="col-sm-8 ml-2 ml-sm-0">
            <div>{component "rating.stars" value=$entity->getRating()}</div>
            <div class="mt-2 text-muted">{$entity->getDateCreateFormat()}</div>
        </div>
    </div>
    <div class="row m-sm-3">
        <div class="col-12 pl-sm-5">
            {component "bs-text" text=$entity->getText()}
            
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
            
            <div class="row mt-2">
                <div class="col-sm-8"></div>
                <div class="col-sm-4 align-content-end">
                    
                </div>
            </div>
            
            {if $entity->getArbitrage()}
                {component "arbitrage" entity=$entity->getArbitrage()}
            {/if}
            
            <div class="row mt-3">
                
                <div class="col text-right">
                    {if $entity->getState() == "publish"}
                        <span class="ml-3 text-success">{lang "talk.response.state.{$entity->getState()}"}</span>
                    {/if}
                    {if $entity->getState() == "chat"}
                        <span class="ml-3 text-primary">{lang "talk.response.state.{$entity->getState()}"}</span>
                    {/if}
                    
                    {if $entity->getState() == "arbitrage"}
                        <span class="text-danger">{$aLang.talk.arbitrage.notice.wait_moderate}</span>
                    {/if}
                    <a class="link ml-4" href="{Router::GetPathWebCurrent()}/{$entity->getId()}">
                       {$aLang.talk.arbitrage.link_chat.text}
                    </a>                    
                </div>
            </div>
            
        </div>
    </div>
</div>
