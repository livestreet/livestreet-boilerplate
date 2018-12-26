{if !$oUserCurrent or $oUserCurrent->getId() != $oUserProfile->getId()}
    
    {if !$oUserProfile->getConfirmed() and $oUserProfile->isRole('company')}
        <div class="row">
            <div class="col-12 text-center">
                <u>
                    <a class="text-danger "   href="{router page='profile/confirm'}">
                        {$aLang.user.profile.actions.confirm.text}</a>
                </u>
            </div>
        </div>
    {/if}


    <div class="mx-4 mt-2">
        <div class="row">
            <div class="col-12">
                {component "bs-button" 
                    attributes = ["data-toggle" => "modal", "data-target" => "#responseModal"]
                    classes = "w-100"
                    bmods   = "primary"
                    text    = $aLang.user.profile.actions.response.text}
            </div>
        </div>
        <div class="row">
            <div class="col-12 mt-2">
                {component "bs-button"
                    attributes = ["data-toggle" => "modal", "data-target" => "#proposeModal"]
                    classes = "w-100"
                    bmods   = "success"
                    text    = $aLang.user.profile.actions.proposal.text}
            </div>
        </div>
    </div>
{/if}