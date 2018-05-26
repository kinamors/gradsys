package com.sen.services.impl;


import com.sen.beans.Message;
import com.sen.beans.MessageExample;
import com.sen.daos.MessageMapper;
import com.sen.services.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("messageService")
public class MessageServiceImpl implements MessageService {

    @Autowired
    private MessageMapper messageMapper;


    @Override
    public List<Message> getMessageByTitle(String title) {
        MessageExample example=new MessageExample();
        MessageExample.Criteria criteria=example.createCriteria();
        criteria.andMTitleEqualTo(title);
        return messageMapper.selectByExample(example);
    }

    @Override
    public void saveMessage(Message message) {
        messageMapper.insert(message);
    }

    @Override
    public List<Message> getAllMessages() {
        return messageMapper.selectByExample(null);
    }

    @Override
    public List<Message> getMessageBy(Message message) {
        MessageExample example=new MessageExample();
        MessageExample.Criteria criteria=example.createCriteria();
        if (message.getSno()!=""){
            criteria.andSnoLike("%"+message.getSno()+"%");
        }
        if (message.getTno()!=""){
            criteria.andTnoLike("%"+message.getTno()+"%");
        }
        return messageMapper.selectByExample(example);
    }

    @Override
    public void deleteBatch(List<Integer> del_ids) {
        MessageExample example=new MessageExample();
        MessageExample.Criteria criteria=example.createCriteria();
        criteria.andMIdIn(del_ids);
        messageMapper.deleteByExample(example);

    }

    @Override
    public void deteleSingle(Integer id) {
        messageMapper.deleteByPrimaryKey(id);
    }
}
