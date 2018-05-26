package com.sen.controllers;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sen.beans.Message;
import com.sen.beans.Msg;
import com.sen.services.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@RequestMapping("/messageController")
@Controller
public class MessageController {

    @Autowired
    MessageService messageServiceImpl;

    @ResponseBody
    @RequestMapping("/saveMessage")
    public Msg saveMessage(Message message){
        message.setmDate(new Date(System.currentTimeMillis()));
        messageServiceImpl.saveMessage(message);
        return Msg.success();
    }

    @ResponseBody
    @RequestMapping("/getMessageByTitle")
    public Msg getMessageByTitle(@RequestParam(value = "page",defaultValue = "1")Integer page,@RequestParam("title")String title){
        PageHelper.startPage(page,15);
        List<Message> messages=messageServiceImpl.getMessageByTitle(title);

        PageInfo pageInfo=new PageInfo(messages,5);
        return Msg.success().add("pageInfo",pageInfo);
    }


    @ResponseBody
    @RequestMapping("/getAllMessages")
    public Msg getAllMessages(@RequestParam(value = "page",defaultValue = "1")Integer page){
        PageHelper.startPage(page,12);
        List<Message> messages=messageServiceImpl.getAllMessages();

        PageInfo pageInfo=new PageInfo(messages,5);
        return Msg.success().add("pageInfo",pageInfo);
    }


    @ResponseBody
    @RequestMapping("/getMessageBy")
    public Msg getMessageBy(@RequestParam(value = "page",defaultValue = "1")Integer page, Message message){
        PageHelper.startPage(page,12);
        List<Message> messages=messageServiceImpl.getMessageBy(message);
        if (messages.isEmpty()){
            return Msg.failure().add("s_result","没找到结果，请重新选择");
        }
        PageInfo pageInfo=new PageInfo(messages,5);
        return Msg.success().add("pageInfo",pageInfo);
    }

    @RequestMapping(value = "/message/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteMessageByIds(@PathVariable("ids")String ids){
        if (ids.contains("-")){
            String[] strs=ids.split("-");
            List<Integer> del_ids=new ArrayList<>();
            for (String str : strs) {
                del_ids.add(Integer.parseInt(str));
            }
            messageServiceImpl.deleteBatch(del_ids);

        }else{
            Integer id=Integer.parseInt(ids);
            messageServiceImpl.deteleSingle(id);

        }
        return Msg.success();
    }
}
