<?php

class ModuleRating_MapperRating extends Mapper
{

    public function getRatingStatTarget($sTargetType, $iTargetId)
    {
        $sql = "SELECT vote, COUNT(id) as count FROM ".Config::Get('db.table.rating_vote')
                ." WHERE target_type=? and target_id=? GROUP BY vote";

        $aRows = $this->oDb->select($sql, $sTargetType, $iTargetId);
        $aResult = [];
        foreach ($aRows as $aRow) {
            $aResult[$aRow['vote']] = $aRow['count'];
        }
        return $aResult;
    }

}