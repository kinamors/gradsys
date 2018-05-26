package com.sen.controllers;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sen.beans.Admin;
import com.sen.beans.Msg;
import com.sen.services.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@RequestMapping("/adminController")
@Controller
public class AdminController {

    @Autowired
    AdminService adminServiceImpl;

    @ResponseBody
    @RequestMapping("/saveAdmin")
    public Msg saveAdmin(Admin admin){
        adminServiceImpl.saveAdmin(admin);
        return Msg.success();
    }


    @ResponseBody
    @RequestMapping("checkUsername")
    public Msg checkUsername(@RequestParam("username")String username){
        boolean b=adminServiceImpl.checkUsername(username);
        if (b==true){
            return Msg.success();
        }else {
            return Msg.failure().add("va_msg","用户名已存在");
        }
    }

    @ResponseBody
    @RequestMapping("/getAllAdmins")
    public Msg getAllAdmins(@RequestParam(value = "page",defaultValue = "1")Integer page){
        PageHelper.startPage(page,12);
        List<Admin> admins=adminServiceImpl.getAllAdmins();

        PageInfo pageInfo=new PageInfo(admins,5);
        return Msg.success().add("pageInfo",pageInfo);

    }

    @ResponseBody
    @RequestMapping(value = "/admin/{ids}",method = RequestMethod.DELETE)
    public Msg deleteAdmins(@PathVariable("ids")String ids){
        if (ids.contains("-")){
            String[] strs=ids.split("-");
            List<Integer> del_ids=new ArrayList<>();
            for (String str : strs) {
                del_ids.add(Integer.parseInt(str));
            }
            adminServiceImpl.deleteBatchSp(del_ids);

        }else{
            Integer id=Integer.parseInt(ids);
            adminServiceImpl.deleteSelectPaper(id);

        }
        return Msg.success();
    }

    @ResponseBody
    @RequestMapping("/updatePwd")
    public Msg updatePwd(Admin admin, HttpSession session){
        adminServiceImpl.updatePwd(admin);
        return Msg.success();
    }




}
