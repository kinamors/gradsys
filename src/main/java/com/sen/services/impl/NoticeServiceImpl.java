package com.sen.services.impl;

import com.sen.beans.Notice;
import com.sen.beans.NoticeExample;
import com.sen.daos.NoticeMapper;
import com.sen.services.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    private NoticeMapper noticeMapper;


    @Override
    public List<Notice> getAllNotices() {
        return noticeMapper.selectByExample(null);
    }

    @Override
    public void saveNotice(Notice notice) {
        noticeMapper.insert(notice);
    }

    @Override
    public void deleteBatchSp(List<Integer> del_ids) {
        NoticeExample example=new NoticeExample();
        NoticeExample.Criteria criteria=example.createCriteria();
        criteria.andNoticeIdIn(del_ids);
        noticeMapper.deleteByExample(example);
    }

    @Override
    public void deleteSelectPaper(Integer id) {
        noticeMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Notice getNotice(Integer id) {
        return noticeMapper.selectByPrimaryKey(id);
    }
}
