{**
 * Хлебные крошки
 *
 * @param string  $bmods="success"  Список модификторов основного блока (через пробел)
 * @param string  $bg="light"       Модификтор фона
 * @param string  $classes          Список классов основного блока (через пробел)
 * @param array   $attributes       Список атрибутов основного блока
 * @param array   $items            Крошки
 *}

 
{* Название компонента *}
{$component = "breadcrumb"}

{component_define_params params=[ 'title', 'text',  'bmods', 'items', 'classes', 'attributes' ]}

{* Smarty-блок для изменения опций *}
{block 'breadcrumb_options'}
{/block}


{block 'breadcrumb_content'}
    <nav aria-label="{$component}" class="{cmods name=$component mods=$bmods delimiter="-"} {$classes}" {cattr list=$attributes}>
        <ol class="{$component}">
            {foreach $items as $item name="breadcrumb_for"}
                {if $smarty.foreach.breadcrumb_for.last}
                    <li class="breadcrumb-item active" aria-current="page">{$item.text}</li>
                {else}
                    <li class="breadcrumb-item"><a href="{$item.url}">{$item.text}</a></li>
                {/if}
            {/foreach}
        </ol>
    </nav>
{/block}