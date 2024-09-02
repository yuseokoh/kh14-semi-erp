package com.kh.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.erp.dao.ChangeLogDao;
import com.kh.erp.dto.ChangeLogDto;

@Service
public class ChangeLogService {

    @Autowired
    private ChangeLogDao changeLogDao;

    public List<ChangeLogDto> getChangeLogsByStockNo(int stockNo) {
        return changeLogDao.selectChangeLogsByStockNo(stockNo);
    }

    public void addChangeLog(int stockNo, String changedFields, String oldValues, String newValues) {
        changeLogDao.insertChangeLog(stockNo, changedFields, oldValues, newValues);
    }
    
    // 모든 변경 로그를 조회
    public List<ChangeLogDto> getAllChangeLogs() {
        return changeLogDao.selectAllChangeLogs();
    }
    
   
}
