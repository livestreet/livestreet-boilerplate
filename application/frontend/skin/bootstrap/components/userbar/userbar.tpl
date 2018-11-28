{**
 * Юзербар
 *}
<!-- Navigation -->
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="{router page='/'}">{Config::Get('view.name')}</a>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            {if $oUserCurrent}
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a class="dropdown-toggle" href="#" data-toggle="dropdown">
                            {$oUserCurrent->getDisplayName()|escape}
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="{$oUserCurrent->getUrl()}">Профиль</a></li>
                            <li><a href="{$oUserCurrent->getUrl()}">Другое</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="{router page='auth/logout'}?security_ls_key={$LIVESTREET_SECURITY_KEY}">{$aLang.auth.logout}</a>
                    </li>
                </ul>
            {else}
                <ul class="nav navbar-nav">
                    <li><a class="js-modal-toggle-login" href="{router page='auth/login'}">{$aLang.auth.login.title}</a></li>
                    <li><a class="js-modal-toggle-registration" href="{router page='auth/register'}">{$aLang.auth.registration.title}</a></li>
                </ul>
            {/if}
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container -->
</nav>