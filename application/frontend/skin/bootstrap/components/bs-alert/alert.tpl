{**
 * Уведомления
 *
 * @param string  $title          Заголовок
 * @param mixed   $text           Массив либо строка с текстом уведомления. Массив должен быть в формате: `[ [ title, msg ], ... ]`
 * @param bool    $visible        Показывать или нет уведомление
 * @param bool    $dismissible    Показывать или нет кнопку закрытия
 * @param string  $bmods="success" Список модификторов основного блока (через пробел)
 * @param string  $bg="light"       Модификтор фона
 * @param string  $classes        Список классов основного блока (через пробел)
 * @param array   $attributes     Список атрибутов основного блока
 *}

 
{* Название компонента *}
{$component = "alert"}

{component_define_params params=[ 'title', 'text', 'visible', 'dismissible', 'animate', 'bmods', 'bg', 'classes', 'attributes' ]}

{* Smarty-блок для изменения опций *}
{block 'alert_options'}
{/block}


{block 'alert_content'}
    <div class="{$component} {cmods name=$component mods=$bmods delimiter="-"} {$classes}" {cattr list=$attributes} role="alert">
        {if $title}
            <h4 class="alert-heading">{$title}</h4>
        {/if}

        {$text}
        {if $dismissible}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        {/if}
    </div>
{/block}