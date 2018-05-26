package com.sen.services;

import com.sen.beans.Notice;

import java.util.List;

public interface NoticeService {
    List<Notice> getAllNotices();

    void saveNotice(Notice notice);

    void deleteBatchSp(List<Integer> del_ids);

    void deleteSelectPaper(Integer id);

    Notice getNotice(Integer id);
}
