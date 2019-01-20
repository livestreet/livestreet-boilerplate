{**
 * Предложение
 *}
 
{component_define_params params=[ 'entity']}

<div class="response mt-5">
    <div class="row">
        <div class="col-sm-5">{component "user" oUser=$entity->getUser()}</div>
        <div class="col-sm-7 ml-2 ml-sm-0">
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
            
            <div class="row mt-3">
                <div class="col text-right">
                    {if $entity->getState() == "arbitrage"}
                        <span class="text-danger">{$aLang.talk.arbitrage.notice.wait_moderate}</span>
                    {/if}                   
                </div>
            </div>
            
        </div>
    </div>
</div>
