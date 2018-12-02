{**
 * jumbotron
 *
 * @param string   $title           Заголовок
 * @param string  $bmods="success"  Список модификторов основного блока (через пробел)
 * @param string  $bg="light"       Модификтор фона
 * @param string  $classes          Список классов основного блока (через пробел)
 * @param array   $attributes       Список атрибутов основного блока
 * @param string  $content          Контент
 * @param string  $html             HTML
 * 
 *}
{$component="jumbotron"}

{component_define_params params=[ 'title', 'content', 'html' ]}

{block 'jumbotron_options'}{/block}

{block 'jumbotron_content'}
    <div class="{$component} {cmods name=$component mods=$bmods delimiter="-"} {$classes}" {cattr list=$attributes}>
        {if $title}
            <h1 class="display-4">{$title}</h1>
        {/if}

        {if $content}
            <p class="lead">{$content}</p>
        {/if}
        
        {$html}        
    </div>
{/block}

