{**
 * Страница вывода ошибок
 *}
{if $aMsgError[0].title}
	<h2>{$aLang.error}: <span>{$aMsgError[0].title}</span></h2>
{/if}

<p>{$aMsgError[0].msg}</p>
<p>
    <a href="javascript:history.go(-1);">{$aLang.site_history_back}</a>,
    <a href="{router page='/'}">{$aLang.site_go_main}</a>
</p>