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
    {$breakpoint = Config::Get('view.grid.breakpoint')}
    {$collapse = Config::Get('view.grid.collapse')}
{/block}


{block 'layout_head' append}
    {* Получаем блоки для вывода в сайдбаре *}
    {if $layoutShowSidebar}
        {show_blocks group='left' assign=layoutSidebarBlocks}

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
        <div class="row  no-gutters bg-light shadow-sm">
            <div class="col-xl-1" ></div>

            <div class="col-12 col-xl-10">
                
                {component 'bs-navbar' 
                    classes = "bg-light pr-2" 
                    bmods = "expand-{Config::Get('view.grid.collapse')} light" 
                    brand = [
                        text    => Config::Get('view.name'),
                        url     => {router page="/"},
                        com     => "link",
                        classes => "d-none d-sm-block"
                    ]
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
    
        <div class="row pt-4 no-gutters {hook run='layout_container_class' action=$sAction}">
            <div class="col-xl-1 "></div>
            
            {**
            * Сайдбар
            * Показываем сайдбар
            *}
            {if $layoutShowSidebar}
                <div class="col-12 col-{$breakpoint}-3 col-xl-2 layout-sidebar pr-{$breakpoint}-0">
                    <div class="mx-2">
                        {$layoutSidebarBlocks}
                    </div>
                </div>
            {/if}
            
            <div class="{if $layoutShowSidebar}col-12 col-{$breakpoint}-9 col-xl-8 mt-2 px-2 mt-{$breakpoint}-0
                 {else}col-12 col-xl-10{/if} ">
                <div class="px-2">
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
                        

                        {* Системные сообщения *}
                        {if $layoutShowSystemMessages}
                            {if $aMsgError}
                                {foreach $aMsgError as $sMsgError}
                                    {component 'bs-alert' text=$sMsgError.msg title=$sMsgError.title bmods='danger' dismissible=true}
                                {/foreach}
                            {/if}

                            {if $aMsgNotice}
                                {foreach $aMsgNotice as $sMsgNotice}
                                    {component 'bs-alert' text=$sMsgNotice.msg title=$sMsgNotice.title bmods='primary' dismissible=true}
                                {/foreach}
                            {/if}
                        {/if}
                    {/block}

                    {hook run='layout_content_begin' action=$sAction}

                    {block 'layout_content'}{/block}

                    {hook run='layout_content_end' action=$sAction}
                </div>
            </div>
            

            <div class="col-xl-1"></div>
        </div>
        {* Подвал *}
        <footer class="row no-gutters">
            <div class="col-12">
                {block 'layout_footer'}
                    {hook run='layout_footer_begin'}
                    {hook run='copyright'}
                    {hook run='layout_footer_end'}
                {/block}
            </div>            
        </footer>
        
    {block "layout_modals"}
        {* Подключение модальных окон *}
        {if $oUserCurrent}
            {component "bs-media.modal"}
        {else}
            {component 'bs-auth' template='modal'}
        {/if}
        
        {component 'bs-modal' 
            header  = {lang 'user.userbar.nav.feedback'} 
            id      = "modalFeedback"
            closed  = true
            content = {lang 'feedback.text' email=$oUserAdmin->getMail()}}
    {/block}
    

    {**
    * Тулбар
    * Добавление кнопок в тулбар
    *}
    {add_block group='toolbar' name='component@toolbar-scrollup.toolbar.scrollup' priority=-100}

    {* Подключение тулбара *}
    {component 'toolbar' classes='js-toolbar-default' items={show_blocks group='toolbar'}}

    {hook run='layout_body_end'}    

{/block}

