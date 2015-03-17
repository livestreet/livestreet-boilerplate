/**
 * Инициализации модулей
 *
 * @license   GNU General Public License, version 2
 * @copyright 2013 OOO "ЛС-СОФТ" {@link http://livestreetcms.com}
 * @author    Denis Shakhov <denis.shakhov@gmail.com>
 */

jQuery(document).ready(function ($) {
    // Хук начала инициализации javascript-составляющих шаблона
    ls.hook.run('ls_template_init_start', [], window);

    /**
     * Иниц-ия модулей ядра
     */
    ls.init({
        production: false
    });

    ls.dev.init();

    // Хук конца инициализации javascript-составляющих шаблона
    ls.hook.run('ls_template_init_end', [], window);
});