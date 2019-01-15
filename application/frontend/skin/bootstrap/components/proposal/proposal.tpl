{**
 * Предложение
 *}
 
{component_define_params params=[ 'entity', 'answered' , 'targetUser', 'deleted', 'redirect']}

<div class="proposal mt-5">
    <div class="row">
        {if $targetUser}
            {$oUser = $entity->getTargetUser()}
        {else}
            {$oUser = $entity->getUser()}
        {/if}
        <div class="col-5">{component "user" oUser=$oUser}</div>
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

                {component 'bs-carousel' 
                    classes="slide w-50 mt-3" 
                    indicators=true
                    controls=true  
                    items=$items}
            {/if}
            
            <div class="row mt-2">
                <div class="col-sm-8"></div>
                <div class="col-sm-4 align-content-end">
                    {if $answered  and (!count($entity->getAnswers()))}
                        {$idAnswer = "collapseAnswer{math equation='rand()'}"}
                        <a class="link" data-toggle="collapse" href="#{$idAnswer}" 
                           aria-expanded="false" aria-controls="{$idAnswer}">
                            {$aLang.talk.answer.btn.text}
                        </a>
                    {/if}
                    
                    {if $deleted}
                        <form data-url="{router page='ajax/talk/message-delete'}" data-type="form-ajax">
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
            
            
            {if $answered and  (!count($entity->getAnswers(['target_type' => 'proposal'])))}
                {component "bs-collapse.item" 
                    id      = $idAnswer 
                    content = {component "answer.form" redirect=$redirect target_id = $entity->getId() target_type=$entity->getType()}}
            {/if}

            {foreach $entity->getAnswers(['target_type' => 'proposal']) as $oAnswer}
                {component "answer" entity=$oAnswer deleted=true redirect=$redirect}
            {/foreach}  
            

            
        </div>
    </div>
</div>