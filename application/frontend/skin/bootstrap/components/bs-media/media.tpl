{**
 * Media content
 *}
 
{component_define_params params=[ 'uploader' ]}

{$component="bs-media"}

<div class="{$component} js-media">
    <div class="row">
        <div class="col-12">
            {*component 'media' template='uploader'
                attributes   = [ 'id' => 'media-uploader' ]
                classes      = 'ls-uploader js-media-uploader'*}
            {component 'bs-media.uploader' 
                attributes  = [ 'data-type' => 'media-uploader' ]
                params      = $uploader}
        </div>
    </div>
    <hr>
    {component "bs-media.library"}
</div>

