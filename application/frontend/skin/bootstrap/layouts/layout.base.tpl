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
    <!-- Custom Fonts -->
    <link href='//fonts.googleapis.com/css?family=Open+Sans:300,400,700&amp;subset=latin,cyrillic' rel='stylesheet' type='text/css'>
{/block}

{block 'layout_head' append}
    {* Получаем блоки для вывода в сайдбаре *}
    {show_blocks group='right' assign=layoutSidebarBlocks}

    {$layoutSidebarBlocks = trim( $layoutSidebarBlocks )}
    {$layoutShowSidebar = !!$layoutSidebarBlocks && $layoutShowSidebar}
    <script>
        ls.lang.load({json var = $aLangJs});
        ls.registry.set({json var = $aVarsJs});
    </script>
{/block}

{block 'layout_body'}

    {**
     * Юзербар
     *}
    {component 'userbar'}

    <!-- Page Content -->
    <div class="container js-root-container">

        <div class="row">

            <!-- Blog Post Content Column -->
            <div class="col-lg-8">
                {hook run='content_begin'}

                {* Основной заголовок страницы *}
                {block 'layout_page_title' hide}
                    <h1 class="page-header">
                        {$smarty.block.child}
                    </h1>
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

                <!-- Blog Post -->
            </div>

            {**
             * Сайдбар
             * Показываем сайдбар
             *}
            {if $layoutShowSidebar}
                <div class="col-md-4">
                    {$layoutSidebarBlocks}
                </div>
            {/if}
        </div>
        <!-- /.row -->

        <hr>

        <!-- Footer -->
        <footer>
            {block 'layout_footer'}
                {hook run='footer_begin'}
                <div class="row">
                    <div class="col-lg-12">
                        <p>Copyright &copy; Your Website {date('Y')}</p>
                    </div>
                </div>
                {hook run='footer_end'}
            {/block}
        </footer>

    </div>
    <!-- /.container -->

    {* Подключение модальных окон *}
    {if !$oUserCurrent}
        {component 'auth' template='modal'}
    {/if}

    {**
     * Тулбар
     * Добавление кнопок в тулбар
     *}
    {add_block group='toolbar' name='component@toolbar-scrollup.toolbar.scrollup' priority=-100}
    {* Подключение тулбара *}
    {component 'toolbar' classes='js-toolbar-default' items={show_blocks group='toolbar'}}
{/block}