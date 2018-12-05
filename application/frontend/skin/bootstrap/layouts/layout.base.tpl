{**
* Основной лэйаут, который наследуют все остальные лэйауты
*
* @param boolean $layoutShowSidebar        Показывать сайдбар или нет, сайдбар не будет выводится если он не содержит блоков
* @param string  $layoutNavContent         Название навигации
* @param string  $layoutNavContentPath     Кастомный путь до навигации контента
* @param string  $layoutShowSystemMessages Показывать системные уведомления или нет
*}

{extends 'component@layout.layout'}



{block 'layout_options' append}
    {$layoutShowSidebar = $layoutShowSidebar|default:true}
    {$layoutShowSystemMessages = $layoutShowSystemMessages|default:true}
    {$themeColor = {Config::Get('view.bs_theme.color')}}
    {$themeBg = {Config::Get('view.bs_theme.bg')}}
{/block}


{block 'layout_head' append}
    {* Получаем блоки для вывода в сайдбаре *}
    {if $layoutShowSidebar}
        {show_blocks group='right' assign=layoutSidebarBlocks}

        {$layoutSidebarBlocks = trim( $layoutSidebarBlocks )}
        {$layoutShowSidebar = !!$layoutSidebarBlocks}
    {/if}


{/block}

{block 'layout_body'}
    {*
    *  TODO:Это здесь по причине, что
    *  невозможно совершить вложение компонентов 
    *  наследуемых от одного компонента
    *}
    {component "bootstrap"}

    {hook run='layout_body_begin'}

    {**
    * Основная навигация
    *}
    {block 'nav_main'}
        <div class="row bg-light shadow-sm">
            <div class="col-xl-1" ></div>

            <div class="col-12 col-xl-10">
                {*component "bs-nav" 
                        itemsClasses="d-flex justify-content-start"
                        bmods="fill" 
                        classes="navbar-nav mr-auto" 
                        hook="main" 
                        activeItem=$sMenuHeadItemSelect 
                        items = [
                            [ 'text' => $aLang.menu.humans.text,   'url' => {router page='humans'},      'name' => 'humans' ],
                            [ 'text' => $aLang.menu.companies.text,     'url' => {router page='companies'},  'name' => 'companies' ]                            
                        ]
                *}
                {component 'bs-navbar' 
                    classes = "bg-light " 
                    bmods = "expand-lg light" 
                    brand = Config::Get('view.name')
                    items = [
                        {insert name='block' block='menu' params=[ 'name' => "main", "activeItem" => $sMenuHeadItemSelect, "mods" => "main" ]}
                    ]
                    after={component 'userbar'}
                }
            </div>
            <div class="col-xl-1"></div>
        </div>
        
    {/block}
    
    {block name="after_nav_main"}
        {*<div class="row mt-1 ">
            <div class="col-xl-1 "></div>
            <div class="col-xl-7 col-12 col-lg-8 ">
                <div class="w-100 ml-3">
                    Хлебные крошки
                </div>
            </div>
            <div class="col-xl-3 d-flex justify-content-md-between col-12 col-lg-4">
                <div class="w-100 d-flex justify-content-md-between ">
                    {component 'search' template='navbar'}
                </div>
            </div>
            <div class="col-xl-1"></div>
        </div>*}
    {/block}
    
    <div class="mt-3 {hook run='layout_container_class' action=$sAction}">
        <div class="row">
            <div class="col-xl-1 "></div>
            <div class="{if $layoutShowSidebar}col-12 col-lg-8 col-xl-7 {else}col-12 col-xl-10{/if}">
                <div class="ml-2">
                    {hook run='layout_content_header_begin' action=$sAction}

                    {block 'layout_page_title' hide}
                        <h2 class="page-header">
                            {$smarty.block.child}
                        </h2>
                    {/block}

                    {block 'layout_content_header'}
                        {* Навигация *}
                        {if $layoutNav}
                            {$_layoutNavContent = ""}

                            {if is_array($layoutNav)}
                                {foreach $layoutNav as $layoutNavItem}
                                    {if is_array($layoutNavItem)}
                                        {component 'bs-nav' 
                                            itemsClasses="m-1" 
                                            bmods='pills' 
                                            params=$layoutNavItem 
                                            assign=_layoutNavItemContent}
                                        {$_layoutNavContent = "$_layoutNavContent $_layoutNavItemContent"}
                                    {else}
                                        {$_layoutNavContent = "$_layoutNavContent $layoutNavItem"}
                                    {/if}
                                {/foreach}
                            {else}
                                {$_layoutNavContent = $layoutNav}
                            {/if}

                            {* Проверяем наличие вывода на случай если меню с одним пунктом автоматом скрывается *}
                            {if $_layoutNavContent|strip:''}
                                <div class="ls-nav-group">
                                    {$_layoutNavContent}
                                </div>
                            {/if}
                        {/if}
                        <hr>

                        {* Системные сообщения *}
                        {if $layoutShowSystemMessages}
                            {if $aMsgError}
                                {component 'bs-alert' text=$aMsgError bmods='danger' dismissible=true}
                            {/if}

                            {if $aMsgNotice}
                                {component 'bs-alert' text=$aMsgNotice dismissible=true}
                            {/if}
                        {/if}
                    {/block}

                    {hook run='layout_content_begin' action=$sAction}

                    {block 'layout_content'}{/block}

                    {hook run='layout_content_end' action=$sAction}
                </div>
            </div>
            {**
            * Сайдбар
            * Показываем сайдбар
            *}
            {if $layoutShowSidebar}
                <aside class="col-12 col-lg-4 col-xl-3 layout-sidebar">
                    <div class="mx-2">
                        {$layoutSidebarBlocks}
                    </div>
                </aside>
            {/if}

            <div class="col-xl-1"></div>
        </div>
        {* Подвал *}
        <footer class="col-12 footer">
            {block 'layout_footer'}
                {hook run='layout_footer_begin'}
                {hook run='copyright'}
                {hook run='layout_footer_end'}
            {/block}
        </footer>
    </div>
        
    {* Подключение модальных окон *}
    {if $oUserCurrent}
        {component 'tags-personal' template='modal'}
    {else}
        {component 'bs-auth' template='modal'}
    {/if}


    {**
    * Тулбар
    * Добавление кнопок в тулбар
    *}
    {add_block group='toolbar' name='component@toolbar-scrollup.toolbar.scrollup' priority=-100}

    {* Подключение тулбара *}
    {component 'toolbar' classes='js-toolbar-default' items={show_blocks group='toolbar'}}

    {hook run='layout_body_end'}    

{/block}

