package com.sen.controllers;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sen.beans.HalfPart;
import com.sen.beans.Msg;
import com.sen.beans.Paper;
import com.sen.services.HalfPartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;

@RequestMapping("/halfPartController")
@Controller
public class HalfPartController {

    @Autowired
    HalfPartService halfPartServiceImpl;



    @ResponseBody
    @RequestMapping("/saveHalfPart")
    public Msg saveHalfPart(HalfPart halfPart){
        halfPart.setAddDate(new Date(System.currentTimeMillis()));
        halfPartServiceImpl.saveHalfPart(halfPart);
        return Msg.success();
    }

    @ResponseBody
    @RequestMapping("/checkProgressHas")
    public Msg checkProgressHas(@RequestParam("sno")String sno){
        boolean b=halfPartServiceImpl.checkProgressHas(sno);
        if (b==true){
            return Msg.success();
        }else{
            HalfPart halfPart=halfPartServiceImpl.getProgressBySno(sno);
            return Msg.failure().add("halfPart",halfPart);
        }
    }


    @ResponseBody
    @RequestMapping("/halfParts")
    public Msg getAllHalfParts(@RequestParam("page")Integer page){
        PageHelper.startPage(page,15);
        List<HalfPart> papers=halfPartServiceImpl.getAllHalfParts();

        PageInfo pageInfo=new PageInfo(papers,5);
        return Msg.success().add("pageInfo",pageInfo);
    }


    @ResponseBody
    @RequestMapping("getHalfPart")
    public Msg getHalfPart(@RequestParam("sno")String sno){
        HalfPart halfPart=halfPartServiceImpl.getHalfPart(sno);
        return Msg.success().add("halfPart",halfPart);

    }

    @ResponseBody
    @RequestMapping("/getHalfPartBy")
    public Msg getHalfPartBy(@RequestParam(value = "page",defaultValue = "1")Integer page, HalfPart halfPart){
        PageHelper.startPage(page,12);
        List<HalfPart> halfParts=halfPartServiceImpl.getHalfPartBy(halfPart);
        if (halfParts.isEmpty()){
            return Msg.failure().add("s_result","没找到结果，请重新选择");
        }
        PageInfo pageInfo=new PageInfo(halfParts,5);
        return Msg.success().add("pageInfo",pageInfo);
    }




}
