<?php

class ModuleUser_EntitySession extends EntityORM
{

    protected $aJsonFields = array(
        'extra'
    );

    protected $aRelations = array(
        'user' => array(self::RELATION_TYPE_BELONGS_TO, 'ModuleUser_EntityUser', 'user_id'),
    );

    /**
     * Проверяет факт активности сессии
     *
     * @return bool
     */
    public function isActive()
    {
        if ($this->getDateClose()) {
            return false;
        }
        return true;
    }

    public function getExtraParam($sName, $mDefault = null)
    {
        $aData = $this->getExtra();
        if (is_array($aData) and array_key_exists($sName, $aData)) {
            return $aData[$sName];
        }
        return $mDefault;
    }

    public function setExtraParam($sName, $mValue)
    {
        $aData = $this->getExtra();
        $aData[$sName] = $mValue;
        $this->setExtra($aData);
    }
}