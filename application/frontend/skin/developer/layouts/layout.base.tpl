{**
 * Основной лэйаут
 *
 * @param string  $layoutNavContent         Название навигации
 * @param string  $layoutNavContentPath     Кастомный путь до навигации контента
 * @param string  $layoutShowSystemMessages Показывать или нет системные сообщения
 *}

{extends 'Component@layout.layout'}

{block 'layout_options' append}
    {$layoutShowSidebar = $layoutShowSidebar|default:true}
    {$layoutShowSystemMessages = $layoutShowSystemMessages|default:true}
{/block}

{block 'layout_head_styles' append}
    <link href='//fonts.googleapis.com/css?family=Open+Sans:300,400,700&amp;subset=latin,cyrillic' rel='stylesheet' type='text/css'>
{/block}

{block 'layout_head' append}
    {* Получаем блоки для вывода в сайдбаре *}
    {if $layoutShowSidebar}
        {show_blocks group='right' assign=layoutSidebarBlocks}

        {$layoutSidebarBlocks = trim( $layoutSidebarBlocks )}
        {$layoutShowSidebar = !!$layoutSidebarBlocks && $layoutShowSidebar}
    {/if}

    {**
     * Тип сетки сайта
     *}
    {if {Config::Get('view.grid.type')} == 'fluid'}
        <style>
            .layout-userbar,
            .layout-nav .ls-nav--main,
            .layout-header .ls-jumbotron-inner,
            .layout-container {
                min-width: {Config::Get('view.grid.fluid_min_width')};
                max-width: {Config::Get('view.grid.fluid_max_width')};
            }
        </style>
    {else}
        <style>
            .layout-userbar,
            .layout-nav .ls-nav--main,
            .layout-header .ls-jumbotron-inner,
            .layout-container { width: {Config::Get('view.grid.fixed_width')}; }
        </style>
    {/if}
{/block}

{block 'layout_body'}
    {**
     * Юзербар
     *}
    {component 'userbar'}

    {**
     * Шапка
     *}
    {if Config::Get( 'view.layout_show_banner' )}
        {component 'jumbotron'
        title    = Config::Get('view.name')
        subtitle = Config::Get('view.description')
        titleUrl = {router page='/'}
        classes  = 'layout-header'}
    {/if}


    {**
     * Основная навигация
     *}
    <nav class="ls-grid-row layout-nav">
        {include 'navs/nav.main.tpl'}
    </nav>
    {**
     * Основной контэйнер
     *}
    <div id="container" class="ls-grid-row layout-container {hook run='container_class'} {if $layoutShowSidebar}layout-has-sidebar{else}layout-no-sidebar{/if}">
        {* Вспомогательный контейнер-обертка *}
        <div class="ls-grid-row layout-wrapper" class="{hook run='wrapper_class'}">
            {**
             * Контент
             *}
            <div class="ls-grid-col ls-grid-col-8 layout-content" role="main" >

                {hook run='content_begin'}

                {* Основной заголовок страницы *}
                {block 'layout_page_title' hide}
                    <h2 class="page-header">
                        {$smarty.block.child}
                    </h2>
                {/block}

                {block 'layout_content_header'}
                    {* Системные сообщения *}
                    {if $layoutShowSystemMessages}
                        {if $aMsgError}
                            {component 'alert' text=$aMsgError mods='error' close=true}
                        {/if}

                        {if $aMsgNotice}
                            {component 'alert' text=$aMsgNotice close=true}
                        {/if}
                    {/if}
                {/block}

                {block 'layout_content'}{/block}

                {hook run='content_end'}
            </div>

            {**
             * Сайдбар
             * Показываем сайдбар
             *}
            {if $layoutShowSidebar}
                <aside class="ls-grid-col ls-grid-col-4 layout-sidebar" role="complementary">
                    {$layoutSidebarBlocks}
                </aside>
            {/if}
        </div> {* /wrapper *}


        {* Подвал *}
        <footer class="ls-grid-row layout-footer">
            {block 'layout_footer'}
                {hook run='footer_begin'}
                {hook run='copyright'}
                {hook run='footer_end'}
            {/block}
        </footer>
    </div>
    {* /container *}

    {* Подключение модальных окон *}
    {if !$oUserCurrent}
        {component 'auth' template='modal'}
    {/if}

    {* Подключение тулбара *}
    {component 'toolbar' classes='js-toolbar-default' items={show_blocks group='toolbar'}}
{/block}