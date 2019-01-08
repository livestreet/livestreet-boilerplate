{**
 * Оповещение о новом сообщении
 *}

{extends 'Component@email.email'}

{block 'content'}
    {lang name='emails.confirm_company.text' params=[
        'name'  => $name,
        'email' => $email,
        'job'   => $job,
        'phone'  => $phone,
        'mess'  => $mess
    ]}
{/block}