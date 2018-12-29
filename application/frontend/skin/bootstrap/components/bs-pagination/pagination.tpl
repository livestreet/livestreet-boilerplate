{**
 * Пагинация
 *
 * @param integer $total
 * @param integer $current
 * @param string  $url
 * @param string  $padding (2)
 * @param bool    $showSingle (false)
 * @param bool    $showPager (false)
 *
 * @param string  $bmods="success"  Список модификторов основного блока (через пробел)
 * @param string  $bg="light"       Модификтор фона
 * @param string  $classes          Список классов основного блока (через пробел)
 * @param array   $attributes       Список атрибутов основного блока
 *}

{* Название компонента *}
{$component = 'pagination'}


{**
 * Элемент пагинации
 *
 * @param bool   $isActive (false) Если true, то элемент помечается как активный (текущая страница)
 * @param string $text             Текст
 * @param string $page             Страница
 * @param string $linkClasses      Дополнительные классы для ссылки
 *}
{function pagination_item page=0 text='' isActive=false attr=[]}
    <li class="page-item {if $isActive}active{/if}" data-page="{$page}" {cattr list=$attr}>
        <a class="page-link  {$linkClasses}" href="{str_replace('__page__', $page, $url)}">{$text|default:$page}</a>
    </li>
{/function}


{component_define_params params=[ 'total', 'showPager', 'showSingle', 'current', 'url', 'padding', 'mods', 'classes', 'attributes' ]}

{* Дефолтные значения *}
{$padding = $padding|default:2}

{block 'pagination_options'}{/block}

{strip}{if ( $showSingle && $total && $current ) || ( ! $showSingle && $total > 1 && $current )}
    {$current = (int)$current}
    {* Вычисляем следующую страницу *}
    {$next = ( $current == $total ) ? 0 : $current + 1}

    {* Вычисляем предыдущую страницу *}
    {$prev = $current - 1}

    {* Вычисляем стартовую и конечную страницы *}
    {$start = 1}
    {$end = $total}

    {* Проверяем нужно ли выводить разделители "..." или нет *}
    {if $total > $padding * 2 + 1}
        {$start = ( $current - $padding < 4 ) ? 1 : $current - $padding}
        {$end = ( $current + $padding > $total - 3 ) ? $total : $current + $padding}
    {/if}


    {* Пагинация *}
    <nav aria-label="Page navigation">

        

        <ul class="{$component}  {cmods name=$component mods=$bmods delimiter="-"} {$classes}" {cattr list=$attributes}>
            {if $showPager and $prev}
            {* Предыдущая страница *}
            {pagination_item page=$prev attr=['data-type' => 'page-prev'] 
                text='<span aria-hidden="true">&laquo;</span><span class="sr-only">Previous</span>'}
            {/if}
            
            {if $start > 2}
                {pagination_item page=1}
                {pagination_item text='...'}
            {/if}

            {section 'pagination' start=$start loop=$end + 1}
                {pagination_item page=$smarty.section.pagination.index attr=['data-type' => 'page-item']
                    isActive=( $smarty.section.pagination.index === $current )}
            {/section}

            {if $end < $total - 1}
                {pagination_item text='...'}
                {pagination_item page=$total attr=['data-type' => 'page-item']}
            {/if}
        
            {if $showPager and $total>$current}
                {* Следущая страница *}
                {pagination_item page=$next attr=['data-type' => 'page-next']  text='<span aria-hidden="true">&raquo;</span><span class="sr-only">Next</span>'}
            {/if}   
            </ul>
    </nav>
{/if}{/strip}