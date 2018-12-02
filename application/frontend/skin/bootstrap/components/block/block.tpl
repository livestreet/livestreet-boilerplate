{**
 * Блок
 *
 * @param string       $title      Заголовок
 * @param string       $content
 * @param boolean      $show
 * @param array|string $list
 * @param array|string $tabs
 * @param string       $mods       Список модификторов основного блока (через пробел)
 * @param string       $classes    Список классов основного блока (через пробел)
 * @param array        $attributes Список атрибутов основного блока
 *}

{$component = 'ls-block'}
{component_define_params params=[ 'title', 'titleUrl', 'content', 'show', 'footer', 'list', 'tabs', 'mods', 'classes', 'attributes' ]}

{block 'block_options'}{/block}

{$show = $show|default:true}

{if $show}
    {capture name="title"}
        {if $titleUrl}
            <a href="{$titleUrl}">{$title}</a>
        {else}
            {$title}
        {/if}
    {/capture}
    
    {capture name="list"}
        {* List group *}
        {if is_array( $list )}
            {component 'bs-list-group' params=$list}
        {elseif $list}
            {$list}
        {/if}
    {/capture}

    {component 'bs-card' 
        bmods=$mods 
        classes="{$classes} mt-3"
        attributes=$attributes 
        text="white" 
        content=[
            [type=>"header", content=>$smarty.capture.title],
            [   
                type => 'body',
                content => [
                    {$smarty.capture.list},
                    [type=>"text", content=>$content],
                    {$footer}
                ]
            ]
        ]
    }
    
{/if}