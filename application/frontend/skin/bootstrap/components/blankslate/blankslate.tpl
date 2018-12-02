{**
 * blankslate
 *
 * @param string $title
 * @param string $text
 * @param boolean $visible
 * @param string $classes
 * @param array  $attributes
 *}

{component_define_params params=[ 'title', 'text', 'visible', 'classes', 'attributes' ]}

{$visible = $visible|default:true}

{component "bs-jumbotron"
    title       = $title
    content     = $text
    classes     = "{if !$visible}d-none{/if} {$classes} text-center"
    attributes  = $attributes
}
