{**
 * Media content
 *}
 
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            {*component 'media' template='uploader'
                attributes   = [ 'id' => 'media-uploader' ]
                classes      = 'ls-uploader js-media-uploader'*}
            {component 'uploader' template='attach'
                classes='js-uploader-attach'
                count=15
                attributes=[
                    'data-param-target_id' => 53,
                    'data-param-target_type' => 'topic'
                ]}
        </div>
    </div>
</div>


<div class="ls-media ls-clearfix {$smarty.local.classes}">
    {*component 'tabs' classes='ls-media-nav js-media-nav' mods='align-left' tabs=[
        [ 'text' => {lang 'media.nav.insert'},   'body' => {component 'media' template='pane.insert'},   'classes' => 'js-tab-show-gallery', 'attributes' => [ 'data-media-name' => 'insert' ] ],
        [ 'text' => {lang 'media.nav.photoset'}, 'body' => {component 'media' template='pane.photoset'}, 'classes' => 'js-tab-show-gallery', 'attributes' => [ 'data-media-name' => 'photoset' ] ],
        [ 'text' => {lang 'media.nav.url'},      'body' => {component 'media' template='pane.url'},      'attributes' => [ 'data-media-name' => 'url' ] ]
    ]*}
</div>