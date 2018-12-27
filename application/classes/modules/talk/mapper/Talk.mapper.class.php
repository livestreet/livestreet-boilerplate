<?php

class ModuleTalk_MapperTalk extends Mapper
{

    public function getAllByFilter($aFilter, $oMapperORM)
    {
        $oEntitySampleR = Engine::GetEntity("Talk_Response");
        $sTableNameR = self::GetTableName($oEntitySampleR);
        
        list($aFilterFieldsR, $sFilterFieldsR, $sJoinTablesR) = $oMapperORM->BuildFilter($aFilter, $oEntitySampleR);
        list($sOrderR, $sLimitR, $sGroupR, $sSelectR) = $oMapperORM->BuildFilterMore($aFilter, $oEntitySampleR);
        
        $oEntitySampleP = Engine::GetEntity("Talk_Proposal");
        $sTableNameP = self::GetTableName($oEntitySampleP);
        
        list($aFilterFieldsP, $sFilterFieldsP, $sJoinTablesP) = $oMapperORM->BuildFilter($aFilter, $oEntitySampleP);
        list($sOrderP, $sLimitP, $sGroupP, $sSelectP) = $oMapperORM->BuildFilterMore($aFilter, $oEntitySampleP);
        
        $sFieldsJoinReturn = $this->GetFieldsRelationTarget();
        $sql = "(SELECT * FROM ".$sTableNameR." WHERE 1=1 {$sFilterFields} {$sGroup} {$sLimit})
                UNION
                (SELECT * FROM ".$sTableNameP."  WHERE 1=1 {$sFilterFields} {$sGroup} {$sLimit})
                {$sOrder}";

        $aResult = array();
        if ($aRows = $this->oDb->select($sql, $iUserId ? $iUserId : DBSIMPLE_SKIP, $iTargetId, $sTargetType)) {
            $aResult = $this->PrepareResultTarget($aRows);
        }
        return $aResult;
    }

}