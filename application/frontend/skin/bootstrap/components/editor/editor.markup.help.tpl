{**
 * Справка по разметке редактора
 *}

{$component = 'editor-help'}
{component_define_params params=[ 'targetId' ]}

{function editor_help_item}
{strip}
    {foreach $items as $item}
        <dl class="{$component}-item">
            {foreach $item['tags'] as $tag}
                <dt>
                    <a href="#" class="ls-link-dotted js-tags-help-link" {if $tag['insert']}data-insert="{$tag['insert']}"{/if}>
                        {$tag['text']}
                    </a>
                </dt>
            {/foreach}

            <dd>{$item['def']}</dd>
        </dl>
    {/foreach}
{/strip}
{/function}


<div class="{$component} js-editor-help" data-form-id="{$targetId}">
    <header class="{$component}-header ls-clearfix">
        <a href="#" class="ls-link-dotted help-link js-editor-help-toggle">{$aLang.editor.markup.help.link_show}</a>
    </header>

    <div class="{$component}-body js-editor-help-body">
        <h3 class="h3">{$aLang.editor.markup.help.special}</h3>

        <div class="ls-mb-30">
            {editor_help_item items=[
                [ 'tags' => [ [ 'text' => '&lt;cut&gt;' ] ], 'def' => $aLang.editor.markup.help.special_cut ],
                [ 'tags' => [ [ 'text' => "&lt;cut name=\"{$aLang.editor.markup.help.special_cut_name_example_name}\"&gt;" ] ], 'def' => $aLang.editor.markup.help.special_cut_name ],
                [ 'tags' => [ [ 'text' => "&lt;video&gt;http://...&lt;/video&gt;", 'insert' => '&lt;video&gt;&lt;/video&gt;' ] ], 'def' => $aLang.editor.markup.help.special_video ],
                [ 'tags' => [ [ 'text' => "&lt;ls user=\"{$aLang.editor.markup.help.special_ls_user_example_user}\" /&gt;", 'insert' => '&lt;ls user=&quot;&quot; /&gt;' ] ], 'def' => $aLang.editor.markup.help.special_ls_user ]
            ]}
        </div>

        <h3 class="h3">{$aLang.editor.markup.help.standart}</h3>

        <div class="ls-clearfix">
            <ul class="{$component}-col">
                {editor_help_item items=[
                    [ 'tags' => [
                        [ 'text' => '&lt;h4&gt;&lt;/h4&gt;' ],
                        [ 'text' => '&lt;h5&gt;&lt;/h5&gt;' ],
                        [ 'text' => '&lt;h6&gt;&lt;/h6&gt;' ]
                    ], 'def' => $aLang.editor.markup.help.standart_h ],
                    [ 'tags' => [ [ 'text' => "&lt;img src=\"\" /&gt;" ] ], 'def' => $aLang.editor.markup.help.standart_img ],
                    [ 'tags' => [
                        [ 'text' => "&lt;a href=\"http://...\"&gt;{$aLang.editor.markup.help.standart_a_example_href}&lt;/a&gt;", 'insert' => '&lt;a href=&quot;&quot;&gt;&lt;/a&gt;"' ]
                    ], 'def' => $aLang.editor.markup.help.standart_a ],
                    [ 'tags' => [ [ 'text' => "&lt;b&gt;&lt;/b&gt;" ] ], 'def' => $aLang.editor.markup.help.standart_b ],
                    [ 'tags' => [ [ 'text' => "&lt;i&gt;&lt;/i&gt;" ] ], 'def' => $aLang.editor.markup.help.standart_i ],
                    [ 'tags' => [ [ 'text' => "&lt;s&gt;&lt;/s&gt;" ] ], 'def' => $aLang.editor.markup.help.standart_s ],
                    [ 'tags' => [ [ 'text' => "&lt;u&gt;&lt;/u&gt;" ] ], 'def' => $aLang.editor.markup.help.standart_u ]
                ]}
            </ul>

            <ul class="{$component}-col">
                {editor_help_item items=[
                    [ 'tags' => [ [ 'text' => "&lt;hr /&gt;" ] ], 'def' => $aLang.editor.markup.help.standart_hr ],
                    [ 'tags' => [ [ 'text' => "&lt;blockquote&gt;&lt;/blockquote&gt;" ] ], 'def' => $aLang.editor.markup.help.standart_blockquote ],
                    [ 'tags' => [
                        [ 'text' => '&lt;table>&lt;/table&gt;' ],
                        [ 'text' => '&lt;th>&lt;/th&gt;' ],
                        [ 'text' => '&lt;td>&lt;/td&gt;' ],
                        [ 'text' => '&lt;tr>&lt;/tr&gt;' ]
                    ], 'def' => $aLang.editor.markup.help.standart_table ],
                    [ 'tags' => [
                        [ 'text' => '&lt;ul&gt;&lt;/ul&gt;' ],
                        [ 'text' => '&lt;li&gt;&lt;/li&gt;' ]
                    ], 'def' => $aLang.editor.markup.help.standart_ul ],
                    [ 'tags' => [
                        [ 'text' => '&lt;ol&gt;&lt;/ol&gt;' ],
                        [ 'text' => '&lt;li&gt;&lt;/li&gt;' ]
                    ], 'def' => $aLang.editor.markup.help.standart_ol ]
                ]}
            </ul>
        </div>
    </div>
</div>
