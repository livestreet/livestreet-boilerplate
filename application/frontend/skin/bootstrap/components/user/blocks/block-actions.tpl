{if !$oUserCurrent or $oUserCurrent->getId() != $oUserProfile->getId()}
    
    {if !$oUserProfile->getConfirmed() and $oUserProfile->isRole('company')}
        <div class="row">
            <div class="col-12 text-center">
                <u class="nav">
                    <li class="nav-item  ">
                        <a class="text-danger nav-link" data-toggle = "modal" data-target = "#confirmModal"  href="#">
                            {$aLang.user.profile.actions.confirm.text}</a>
                    </li>
                </u>
            </div>
        </div>
    {/if}

{*    Кнопки добавления отзыва и ппредложения*}
    {if $oUserCurrent or (!$oUserCurrent and Config::Get('module.user.user_guest'))}
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
                        attributes = ["data-toggle" => "modal", "data-target" => "#proposalModal"]
                        classes = "w-100"
                        bmods   = "success"
                        text    = $aLang.user.profile.actions.proposal.text}
                </div>
            </div>
        </div>
    {/if}
{/if}