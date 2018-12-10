{**
 * Всплывающее окно
 *
 
 *}{strip}
 


{component_define_params params=[ 'type', 'content', 'placement', 'title' , 'trigger' ]}

    
{block name="content_popover"}{strip}
    data-toggle="{$type|default:"popover"}"{" "}
    data-content="{$content}"{" "}
    data-placement="{$placement|default:"top"}"{" "}
    {if $title}
        title="{$title}"{" "}
    {/if}
    data-trigger="{$trigger|default:"hover"}"{" "}
{/strip}{/block}

