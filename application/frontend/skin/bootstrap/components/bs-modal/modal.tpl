{**
 * Модальное окно
 *
 * @param string  $header           Заголовок
 * @param string  $bmods="success"  Список модификторов основного блока (через пробел)
 * @param string  $bg="light"       Модификтор фона
 * @param string  $classes          Список классов основного блока (через пробел)
 * @param array   $attributes       Список атрибутов основного блока
 * @param string  $content          Контент
 * @param string  $footer           Подвал
 * @param bool  $centered           По центру страницы
 * 
 *}
{$component="modal"}

{component_define_params params=[ 'showFooter', 'header', 'content', 'footer', 'closeText', 'primaryButton', 'html', 'id', 'labelledby', 'effect', 'centered']}

{$attributes.id=$id}
{$attributes.tabindex="-1"}
{$attributes.role="dialog"}
{$attributes["aria-labelledby"]=$labelledby}
{$attributes["aria-hidden"]="true"}
{if $centered}
    {$bmods = "{$bmods} dialog-centered"}
{/if}

{block 'modal_options'}{/block}

{block 'modal_content'}
    <div class="{$component} {$effect|default:"fade"}  {$classes}" {cattr list=$attributes}>
        <div class="modal-dialog {cmods name=$component mods=$bmods delimiter="-"} " role="document">
            <div class="modal-content">
                {if $header}
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">{$header}</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                {/if}

                {if $content}
                    <div class="modal-body">
                        {$content}
                    </div>
                {/if}

                {if $showFooter}

                    {if $footer}
                        <div class="modal-footer">
                            {$footer}
                        </div>
                    {else}
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">{$closeText|default:$aLang.common.close}</button>
                            <button type="button" class="{$primaryButton.classes} btn btn-primary">{$primaryButton.text|default:"Ok"}</button>
                        </div>
                    {/if}  
                {/if}      
            </div>
        </div>
    </div>
{/block}

