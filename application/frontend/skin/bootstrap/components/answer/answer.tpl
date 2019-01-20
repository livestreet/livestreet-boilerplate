{**
 * Предложение
 *}
 
{component_define_params params=[ 'entity', 'deleted', 'redirect']}

<div class="response mt-2">
    <div class="row">
        <div class="col-5">{component "user" oUser=$entity->getUser()}</div>
        <div class="col-7 align-self-end text-muted">{$entity->getDateCreateFormat()}</div>
    </div>
    <div class="row m-3">
        <div class="col-12 pl-5">
            {component "bs-text" text=$entity->getText() }
            
            {if is_array($entity->getMedia()) and count($entity->getMedia())}
                {$items = []}
                {foreach $entity->getMedia() as $oMedia}
                    {$items[] = [
                        href    => $oMedia->getFileWebPath(),
                        src     => $oMedia->getFileWebPath('x200crop')
                    ]}
                {/foreach}
                <div class="row">
                    <div class="col-sm-6 col-md-3">
                        {$controls = (count($items)>1)}
                        {component 'bs-carousel' 
                            classes     = "slide w-100 mt-3"  
                            indicators  = $controls 
                            controls    = $controls  
                            items       = $items}
                    </div>
                </div>
                    
                
                
            {/if}
            <div class="row mt-2">
                <div class="col-sm-8"></div>
                <div class="col-sm-4 align-content-end">
                    {if $deleted and $oUserCurrent and $entity->getUser()->getId() == $oUserCurrent->getId()}
                        <form data-url="{router page='ajax/talk/message-delete'}" data-form-ajax>
                            <input type="hidden" name="id" value="{$entity->getId()}">
                            <input type="hidden" name="redirect" value="{$redirect}">
                            {component "bs-button" 
                                attributes = ['data-confirm-remove' => true]
                                bmods   = "link"  
                                classes = "text-danger" 
                                type    = "submit" 
                                text    = $aLang.common.remove}
                        </form>
                    {/if}
                    
                </div>
            </div>
            
        </div>
    </div>
</div>