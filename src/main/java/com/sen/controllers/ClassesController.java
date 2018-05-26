package com.sen.controllers;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sen.beans.Classes;
import com.sen.beans.Msg;
import com.sen.services.ClassesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RequestMapping("/classesController")
@Controller
public class ClassesController {

    @Autowired
    ClassesService classesServiceImpl;

    @ResponseBody
    @RequestMapping("/getClassesByCId")
    public Msg getClassesByCId(@RequestParam("cid")String cId){
        List<Classes> classes=classesServiceImpl.getClassesByCId(cId);
        if (classes.isEmpty()){
            return Msg.failure();
        }
        return Msg.success().add("classes",classes);
    }

    @ResponseBody
    @RequestMapping("/getColAndClasses")
    public Msg getColAndClasses(@RequestParam(value = "page",defaultValue = "1")Integer page){
        PageHelper.startPage(page,12);
        List<Classes> colAndClasses=classesServiceImpl.getAllWithCollege();
        PageInfo pageInfo=new PageInfo(colAndClasses,5);
        return Msg.success().add("pageInfo",pageInfo);
    }


    @ResponseBody
    @RequestMapping("checkClassName")
    public Msg checkClassName(@RequestParam("className")String className){
        boolean b=classesServiceImpl.checkClassName(className);
        if (b==true){
            return Msg.success();
        }else {
            return Msg.failure().add("va_msg","班级名称已存在");
        }
    }

    @ResponseBody
    @RequestMapping("/saveClasses")
    public Msg saveClasses(Classes classes){
        classesServiceImpl.saveClasses(classes);

        return Msg.success();
    }

    @ResponseBody
    @RequestMapping(value = "/classes/{ids}",method = RequestMethod.DELETE)
    public Msg deleteClasses(@PathVariable("ids")String ids){
        if (ids.contains("-")){
            String[] strs=ids.split("-");
            List<Integer> del_ids=new ArrayList<>();
            for (String str : strs) {
                del_ids.add(Integer.parseInt(str));
            }
            classesServiceImpl.deleteBatchSp(del_ids);

        }else{
            Integer id=Integer.parseInt(ids);
            classesServiceImpl.deleteSelectPaper(id);

        }
        return Msg.success();
    }
}
