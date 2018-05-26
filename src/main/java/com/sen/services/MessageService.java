package com.sen.services;

import com.sen.beans.Message;

import java.util.List;

public interface MessageService {

    List<Message> getMessageByTitle(String title);

    void saveMessage(Message message);

    List<Message> getAllMessages();

    List<Message> getMessageBy(Message message);

    void deleteBatch(List<Integer> del_ids);

    void deteleSingle(Integer id);
}
