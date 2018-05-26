package com.sen.services;

import com.sen.beans.UpLoadRecord;

import java.util.List;

public interface UpRecordService {

    void saveUpRecord(UpLoadRecord upLoadRecord);

    List<UpLoadRecord> getReportUpRecord();


    List<UpLoadRecord> getAllUpRecord();

    List<UpLoadRecord> getUpRecordBy(UpLoadRecord upLoadRecord);

    List<UpLoadRecord> getTransUpRecord();

    List<UpLoadRecord> getPaperUpRecord();

    void deleteFiles(Integer id);
}
