{**
 * Предложение
 *}
{$component="list-ajax"}
 
{component_define_params params=[ 'url', 'attributes', 'counterSelector', 'classes', 'mods', 'limit', 'content']}

{block name="response_ajax_option"}
    {$attributes["data-onload-start"] = "true"}
    {$attributes["data-ajax-list"] = "true"}
    {$attributes["data-url"] = $url}
    {if $counterSelector}
        {$attributes["data-counter-selector"] = $counterSelector}
    {/if}
    {if $limit}
        {$attributes["data-param-limit"] = $limit}
    {/if}
    
{/block}


<div class="{$component} {cmods name=$component mods=$mods delimiter="-"} {$classes}" {cattr list=$attributes}>
    <div data-ajax-container>{$content}</div>
    <div class="d-flex justify-content-center">
        {component "bs-button" 
            classes     = "mt-3"
            bmods       = "primary"
            attributes  = ['data-load-btn' => true]
            text        = $aLang.more.text}
    </div>
</div>
