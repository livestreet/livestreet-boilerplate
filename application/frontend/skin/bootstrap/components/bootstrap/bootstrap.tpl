{**
 * Bootstrap function
 * 
 *}

{function bmods}{strip}

    {if $bg}
        {"bg-{$bg} "}
    {/if}
    
    {if $textMod}
        {"text-{$textMod} "}
    {/if}
    
    {if $border}
        {"border-{$border} "}
    {/if}

    {if $bmods}
        {cmods name=$component mods=$bmods delimiter="-"}
    {/if}      
    
    {if $dismissible}
        {"{$component}-dismissible "}
    {/if} 
    
    {if $animate}
        {"fade show "}
    {/if}
{/strip}{/function}

{function bs_popover popover=$popover}{strip}
    {if $popover and is_array($popover)}
        data-toggle="{$popover.type|default:"popover"}"{" "}
        {if $popover.content}
            data-content="{$popover.content}"{" "}
        {/if}
        {if $popover.placement}
            data-placement="{$popover.placement}"{" "}
        {/if}
        {if $popover.title}
            title="{$popover.title}"{" "}
        {/if}
        data-trigger="{$popover.trigger|default:"hover"}"{" "}
    {/if}
{/strip}{/function}
