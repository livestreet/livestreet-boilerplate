{**
 * Оповещение о новом сообщении
 *}

{extends 'Component@email.email'}

{block 'content'}
    {lang name='emails.confirm_company.text' params=[
        'company_url' => $company_url,
        'company_name' => $company_name,
        'name'  => $name,
        'mail' => $mail,
        'job'   => $job,
        'phone'  => $phone,
        'mess'  => $mess
    ]}
{/block}