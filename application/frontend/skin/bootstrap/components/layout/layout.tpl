{**
 * Layout
 *
 * @param string $sHtmlTitle
 * @param string $sHtmlDescription
 * @param string $sHtmlKeywords
 * @param array  $aHtmlHeadFiles
 *}
<!doctype html>

{$component = 'layout'}
{component_define_params params=[ 'mods', 'classes', 'attributes' ]}

{block 'layout_options'}
    {$rtl = ( Config::Get('view.rtl') ) ? 'dir="rtl"' : ''}
    {$lang = Config::Get('lang.current')}
{/block}

<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="{$lang}" {$rtl}> <![endif]-->
<!--[if IE 7]>    <html class="no-js ie7 oldie" lang="{$lang}" {$rtl}> <![endif]-->
<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="{$lang}" {$rtl}> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="{$lang}" {$rtl}> <!--<![endif]-->

<head prefix="og: https://ogp.me/ns# article: https://ogp.me/ns/article#">
    {block 'layout_head'}
        <meta charset="utf-8">

        <meta name="description" content="{$sHtmlDescription}">
        <meta name="keywords" content="{$sHtmlKeywords}">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="robots" content="{$sHtmlRobots}">

        <title>{block 'layout_title'}{$sHtmlTitle}{/block}</title>

        {* RSS *}
        {if $aHtmlRssAlternate}
            <link rel="alternate" type="application/rss+xml" href="{$aHtmlRssAlternate.url}" title="{$aHtmlRssAlternate.title}">
        {/if}

        {* Canonical *}
        {if $sHtmlCanonical}
            <link rel="canonical" href="{$sHtmlCanonical}" />
        {/if}

        {**
         * Стили
         * CSS файлы подключаются в конфиге шаблона (ваш_шаблон/settings/config.php)
         *}
        {block 'layout_head_styles'}
            {* Подключение стилей указанных в конфиге *}
            {$aHtmlHeadFiles.css}
        {/block}

        <link href="{cfg 'path.skin.assets.web'}/images/favicons/favicon.ico?v1" rel="shortcut icon" />

        <script>
            {strip}
            var PATH_ROOT                   = '{router page='/'}',
                    PATH_SKIN                   = '{cfg 'path.skin.web'}',
                    PATH_FRAMEWORK_FRONTEND     = '{cfg 'path.framework.frontend.web'}',
                    PATH_FRAMEWORK_LIBS_VENDOR  = '{cfg 'path.framework.libs_vendor.web'}',

                    LIVESTREET_SECURITY_KEY = '{$LIVESTREET_SECURITY_KEY}',
                    LANGUAGE                = '{Config::Get('lang.current')}',
                    WYSIWYG                 = {if Config::Get('view.wysiwyg')}true{else}false{/if},
                    ACTION = '{$sAction}';

            var aRouter = [];
            {foreach $aRouter as $sPage => $sPath}
                aRouter['{$sPage}'] = '{$sPath}';
            {/foreach}
            {/strip}
        </script>

        {block 'layout_head_scripts'}{/block}
    {/block}

    {hook run='html_head_end'}
</head>


{**
 * Модификторы
 *
 * user-role-guest        Посетитель - гость
 * user-role-user         Залогиненый пользователь - обычный пользователь
 * user-role-admin        Залогиненый пользователь - админ
 * user-role-not-admin    Залогиненый пользователь - не админ
 * template-*             Класс с названием активного шаблона
 *}
{if $oUserCurrent}
    {$mods = "$mods user-role-user"}

    {if $oUserCurrent->isAdministrator()}
        {$mods = "$mods user-role-admin"}
    {/if}
{else}
    {$mods = "$mods user-role-guest"}
{/if}

{if !$oUserCurrent or !$oUserCurrent->isAdministrator()}
    {$mods = "$mods user-role-not-admin"}
{/if}

{$mods = "$mods template-{Config::Get('view.skin')} {Config::Get('view.grid.type')}"}

<body class="{$component} {cmods name=$component mods=$mods} {$classes}" {cattr list=$attributes}>
    {block 'layout_body'}{/block}

    {hook run='body_end'}


    {**
     * JavaScript файлы
     * JS файлы подключаются в конфиге шаблона (ваш_шаблон/settings/config.php)
     *}
    {block 'layout_body_end'}
        {* Подключение скриптов указанных в конфиге *}
        {$aHtmlHeadFiles.js}


        <script>
            ls.lang.load({json var = $LS->Lang_GetLangJs()});
            ls.registry.set({json var = $LS->Viewer_GetVarsJs()});
        </script>
    {/block}


    {$sLayoutAfter}
</body>
</html>