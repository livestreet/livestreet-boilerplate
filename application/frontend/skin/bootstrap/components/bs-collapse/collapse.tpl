{**
 * Коллапс
 *
 * @param mixed   $text             Массив либо строка с текстом уведомления. Массив должен быть в формате: `[ [ title, msg ], ... ]`
 * @param string  $bmods="success"  Список модификторов основного блока (через пробел)
 * @param string  $bg="light"       Модификтор фона
 * @param string  $classes          Список классов основного блока (через пробел)
 * @param array   $attributes       Список атрибутов основного блока
 * @param bool    $indicators       Индикаторы
 * @param bool    $controls         Кнопки Previous Next
 *}{strip}
 
 {* Название компонента *}
{$component = "collapse"}

{component_define_params params=[ 'bmods', 'text',  'bg', 'classes', 'attributes',  'btnClasses', 'controls', 'content' ]}

{$id = "collapse{math equation='rand()'}"}

{$params.attributes["data-toggle"] = "collapse"}
{$params.attributes["data-target"] = "#{$id}"}

{block 'collapse_options'}{/block}

{block 'collapse_content'}{strip}
        
    {component 'bs-button' params = $params}
    
    <div class="collapse" id="{$id}">
        {$content}
    </div>
{/strip}{/block}{/strip}