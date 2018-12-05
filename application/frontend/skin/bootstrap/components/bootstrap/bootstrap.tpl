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

