{**
 * Загрузка медиа-файлов
 *}
 
{component_define_params params=[ 'entity', 'id', 'bmods', 'title', 'url' ]}

{if !$entity}
    {$entity=Engine::GetEntity('Talk_Response')}
{/if}

{component "bs-modal" 
    header      = $title|default:$aLang.talk.response.modal.title
    bmods       = $bmods|default:"lg" 
    showFooter  = true
    primaryButton = [
        bmods => "success",
        text => $aLang.talk.response.form.submit.text,
        attributes => ['data-modal-submit' => true]
    ]
    content     = {component 'moderation.response-form' oResponse=$entity url=$url}
    id          = $id|default:"responseModal" }
