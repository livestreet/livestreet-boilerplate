{capture 'modal_content'}
    Содержание модального окна
{/capture}

{component 'modal'
    title   = 'Заголовок окна'
    content = $smarty.capture.modal_content
    classes = 'js-modal-default'
    id      = 'modal-simple'}