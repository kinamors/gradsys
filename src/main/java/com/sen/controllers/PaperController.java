package com.sen.controllers;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sen.beans.Msg;
import com.sen.beans.Paper;
import com.sen.beans.SelectPaper;
import com.sen.services.CollegeService;
import com.sen.services.PaperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@RequestMapping("/paperController")
@Controller
public class PaperController {

    @Autowired
    PaperService paperServiceImpl;

    @Autowired
    CollegeService collegeServiceImpl;

    //SelectPaper
    @ResponseBody
    @RequestMapping("/addSelectPaper")
    public Msg saveSelectPaper(SelectPaper paper, HttpSession session){
        paper.setAddDate(new Date(System.currentTimeMillis()));
        System.out.println(paper.getCreateName());
        paperServiceImpl.saveSp(paper);
        return Msg.success();
    }

    @ResponseBody
    @RequestMapping("/selectPapers")
    public Msg getSelectPapers(@RequestParam(value = "page",defaultValue = "1")Integer page){
        PageHelper.startPage(page,15);
        List<SelectPaper> selectPapers=paperServiceImpl.getAllSelectPapers();

        PageInfo pageInfo=new PageInfo(selectPapers,5);
        return Msg.success().add("pageInfo",pageInfo);
    }

    @ResponseBody
    @RequestMapping("/selectPapersNotChoose")
    public Msg getSelectPapersNotChoose(@RequestParam(value = "page",defaultValue = "1")Integer page){
        PageHelper.startPage(page,15);
        List<SelectPaper> selectPapers=paperServiceImpl.getSelectPapersNotChoose();
        for (SelectPaper selectPaper : selectPapers) {
            System.out.println(selectPaper);
        }
        PageInfo pageInfo=new PageInfo(selectPapers,5);
        return Msg.success().add("pageInfo",pageInfo);
    }

    @ResponseBody
    @RequestMapping("/selectPapersHasChoose")
    public Msg getSelectPapersHasChoose(@RequestParam(value = "page",defaultValue = "1")Integer page){
        PageHelper.startPage(page,15);
        List<SelectPaper> selectPapers=paperServiceImpl.getSelectPapersHasChoose();

        PageInfo pageInfo=new PageInfo(selectPapers,5);
        return Msg.success().add("pageInfo",pageInfo);
    }

    @ResponseBody
    @RequestMapping("/checkTitle")
    public Msg checkSelectTitle(@RequestParam("selectTitle") String title){
        boolean b=paperServiceImpl.checkPaperTitle(title);
        if (b==true){
            return Msg.success();
        }else{
            return Msg.failure().add("va_msg","课题已存在");
        }
    }

    @ResponseBody
    @RequestMapping("/checkSelectId")
    public Msg checkSelectTitle(@RequestParam("selectId") Integer id){
        boolean b=paperServiceImpl.checkPaperId(id);
        if (b==true){
            return Msg.success();
        }else{
            return Msg.failure().add("va_msg","编号已存在");
        }
    }

    @RequestMapping(value = "/selectPaper/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteSelectPaperById(@PathVariable("ids")String ids){
        if (ids.contains("-")){
            String[] strs=ids.split("-");
            List<Integer> del_ids=new ArrayList<>();
            for (String str : strs) {
                del_ids.add(Integer.parseInt(str));
            }
            paperServiceImpl.deleteBatchSp(del_ids);

        }else{
            Integer id=Integer.parseInt(ids);
            paperServiceImpl.deleteSelectPaper(id);

        }
        return Msg.success();
    }

    @RequestMapping(value = "/selectPaper/{id}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateSelectPaper(@PathVariable("id")Integer id, SelectPaper paper){
        paper.setSelectId(id);
        paperServiceImpl.updateSelectPaper(paper);
        return  Msg.success();
    }


    @RequestMapping(value = "/selectPaper/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getSelectPaper(@PathVariable("id") Integer id){

        SelectPaper paper=paperServiceImpl.getSelectPaperById(id);

        return Msg.success().add("selectPaper",paper);
    }





    //Paper
    @ResponseBody
    @RequestMapping("/savePaper")
    public Msg savePaper(Paper paper){
        paperServiceImpl.savePaper(paper);
        return Msg.success();
    }
    @ResponseBody
    @RequestMapping("/checkPaperHas")
    public Msg checkPaperHas(@RequestParam("pId") Integer id){
        boolean b=paperServiceImpl.checkPaperHas(id);
        if (b==true){
            return Msg.success();
        }else{
            return Msg.failure().add("va_msg","编号已存在");
        }
    }

    @ResponseBody
    @RequestMapping("/papers")
    public Msg getAllPapers(@RequestParam(value = "page",defaultValue = "1")Integer page){
        PageHelper.startPage(page,15);
        List<Paper> papers=paperServiceImpl.getAllPapers();

        PageInfo pageInfo=new PageInfo(papers,5);
        return Msg.success().add("pageInfo",pageInfo);
    }
    @ResponseBody
    @RequestMapping("/getPaperBy")
    public Msg getPaperBy(@RequestParam(value = "page",defaultValue = "1")Integer page, Paper paper,
                          @RequestParam("collegeId")String collegeId){
        PageHelper.startPage(page,12);
        paper.setCollege(collegeServiceImpl.selectByPrimaryKey(collegeId).getCname());
        List<Paper> papers=paperServiceImpl.getPaperBy(paper);
        if (papers.isEmpty()){
            return Msg.failure().add("s_result","没找到结果，请重新选择");
        }
        PageInfo pageInfo=new PageInfo(papers,5);
        return Msg.success().add("pageInfo",pageInfo);
    }


    @ResponseBody
    @RequestMapping("/paper/{id}")
    public Msg getPaperByPId(@PathVariable("id")Integer pId){
        Paper paper=paperServiceImpl.getPaperByPId(pId);

        if (paper!=null){
            return Msg.success().add("paper",paper);

        }
        return Msg.failure();
    }





}
