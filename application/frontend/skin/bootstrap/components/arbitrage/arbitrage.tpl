{**
 * Предложение
 *}
 
{component_define_params params=[ 'entity']}

<div class="arbitrage mt-5">
    <div class="row">
        <div class="col-5">{component "user" oUser=$entity->getUser()}</div>
        <div class="col-7 align-self-end text-muted">{$entity->getDateCreateFormat()}</div>
    </div>
    <div class="row m-3">
        <div class="col-12 pl-5">
            {component "bs-text" text=$entity->getText()}
            
            {if is_array($entity->getMedia()) and count($entity->getMedia())}
                {$items = []}
                {foreach $entity->getMedia() as $oMedia}
                    {$items[] = [
                        href    => $oMedia->getFileWebPath(),
                        src     => $oMedia->getFileWebPath('x200crop')
                    ]}
                {/foreach}

                {component 'bs-carousel' classes="slide w-25 mt-3" indicators=true controls=true  items=$items}
            {/if}
            
            
        </div>
    </div>
</div>