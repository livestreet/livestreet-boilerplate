
{capture name="content"}
    <div class="row mb-1">
        <div class="col-12"  data-type="img"></div>
    </div>
    <div class="row mb-1">
        <div class="col-sm-6 col-12">{$aLang.media.library.info.list.id}</div>
        <div class="col-sm-6 col-12" data-type="id"></div>
    </div>
    <div class="row mb-1">
        <div class="col-sm-6 col-12">{$aLang.media.library.info.list.name}</div>
        <div class="col-sm-6 col-12" data-type="name"></div>
    </div>
    <div class="row mb-1" >
        <div class="col-sm-6 col-12">{$aLang.media.library.info.list.date}</div>
        <div class="col-sm-6 col-12" data-type="date"></div>
    </div>
    <div class="row mb-1">
        <div class="col-sm-6 col-12">{$aLang.media.library.info.list.dimensions}</div>
        <div class="col-sm-6 col-12" data-type="dimensions"></div>
    </div>
    <div class="row mb-1">
        <div class="col-sm-6 col-12">{$aLang.media.library.info.list.size}</div>
        <div class="col-sm-6 col-12" data-type="size"></div>
    </div>
    <div class="row">
        <div class="col-sm-6 col-12">{$aLang.media.library.info.list.count_targets}</div>
        <div class="col-sm-6 col-12" data-type="count-targets"></div>
    </div>
    {*<div class="row">
        <div class="col-sm-6 col-12">{$aLang.media.library.info.list.sizes}</div>
        <div class="col-sm-6 col-12" data-type="sizes"></div>
    </div>*}
{/capture}

{capture name="actions"}
    {*{component "bs-button"
        bmods       = "primary "
        attributes  = ['data-type' => 'crop-btn']
        popover     = [content => $aLang.media.library.cutButton.title]
        text        = {component "icon" icon="cut"}
        type        = "button"
        classes     = ""}*}
    {component "bs-button"
        bmods       = "danger"
        attributes  = ['data-type' => 'file-remove']
        popover     = [content => $aLang.common.remove]
        text        = {component "icon" icon="trash"}
        type        = "button"
        classes     = ""}
{/capture}

{component "bs-card" classes="d-none"
    attributes = ['data-type' => 'file-info']
    content=[
        [
            type => 'body',
            content => $smarty.capture.content
        ],
        [
            type => 'footer',
            content => $smarty.capture.actions
        ]
    ]}