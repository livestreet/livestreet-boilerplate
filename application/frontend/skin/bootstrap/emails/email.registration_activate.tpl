{**
 * Подтверждение регистрации
 *}

{extends 'Component@email.email'}

{block 'content'}
	{lang name='emails.registration_activate.text' params=[
		'website_url'    => Router::GetPath('/'),
		'website_name'   => Config::Get('view.name'),
		'mail'      => $oUser->getMail(),
		'password'  => $sPassword,
		'activation_url' => "{router page='auth'}activate/{$oUser->getActivateKey()}/"
	]}
{/block}