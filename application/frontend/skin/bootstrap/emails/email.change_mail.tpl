{**
 * Повторная активация
 *}

{extends 'Component@email.email'}

{block 'content'}
    {lang name='emails.change_mail.text' params=[
        'website_url'    => Router::GetPath('/'),
        'website_name'   => Config::Get('view.name'),
        'change_url'    => $sChangeUrl
    ]}
{/block}