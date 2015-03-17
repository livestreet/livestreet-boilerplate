<?php

require_once(dirname(dirname(dirname(__DIR__))) . '/bootstrap/start.php');

class NotifyCron extends Cron
{
    /**
     * Выбираем пул заданий и рассылаем по ним e-mail
     */
    public function Client()
    {
        $aNotifyTasks = $this->Notify_GetTasksDelayed(Config::Get('module.notify.per_process'));

        if (empty($aNotifyTasks)) {
            $this->Log("No tasks are found.");
            return;
        }
        /**
         * Последовательно загружаем задания на публикацию
         */
        $aArrayId = array();
        foreach ($aNotifyTasks as $oTask) {
            $this->Notify_SendTask($oTask);
            $aArrayId[] = $oTask->getTaskId();
        }
        $this->Log("Send notify: " . count($aArrayId));
        /**
         * Удаляем отработанные задания
         */
        $this->Notify_DeleteTaskByArrayId($aArrayId);
    }
}

/**
 * Создаем объект крон-процесса,
 * передавая параметром путь к лок-файлу
 */
$app = new NotifyCron(Config::Get('sys.cache.dir') . 'notify.lock');
print $app->Exec();