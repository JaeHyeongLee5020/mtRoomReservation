package com.jang.mtg.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.jang.mtg.model.MtRoomVO;
import com.jang.mtg.service.MtRoomService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;

@Controller
public class MtRoomController {

    @Autowired
    private MtRoomService mtRoomService;
    
    @RequestMapping(value = "/index")
    public String indexView() throws Exception {
        return "index";
    }
    
    @RequestMapping(value = "/mtRoomList")
    public String mtRoomList(@ModelAttribute("mtRoomVO") MtRoomVO mtRoomVO, Model model, HttpSession session) throws Exception {
        session.setAttribute("userId", "Test20");
        
        List<MtRoomVO> mtRoomList = mtRoomService.getMtRoomList();
        model.addAttribute("mtRoomList", mtRoomList);
        
        return "mtRoomList";
    }
    
    @RequestMapping(value = "/insertMtRoom", method = RequestMethod.GET)
    public String insertMtRoomView(Model model) throws Exception {
        model.addAttribute("mtRoomVO", new MtRoomVO());
        return "mtRoomRegist";
    }

    @RequestMapping(value = "/insertMtRoom", method = RequestMethod.POST)
    public String insertMtRoomOn(@ModelAttribute("mtRoomVO") MtRoomVO mtRoomVO, Model model, HttpSession session, MultipartHttpServletRequest mRequest) throws Exception {
        String userId = (String) session.getAttribute("userId");
        ServletContext servletContext = mRequest.getSession().getServletContext();
        String webappRoot = servletContext.getRealPath("/");
        String relativeFolder = File.separator + "resources" + File.separator + "images" + File.separator;
        
        mtRoomVO.setFirst_Reg_ID(userId);
        List<MultipartFile> fileList = mRequest.getFiles("file_1");

        for (MultipartFile mf : fileList) {
            if (!mf.isEmpty()) {
                String originFileName = mf.getOriginalFilename();
                mtRoomVO.setPicture(originFileName);
                String safeFile = webappRoot + relativeFolder + originFileName;

                try {
                    mf.transferTo(new File(safeFile));
                } catch (IllegalStateException | IOException e) {
                    e.printStackTrace();
                }
            }
        }

        if (this.mtRoomService.insertMtRoom(mtRoomVO) != 0) {
            model.addAttribute("mtRoomVO", mtRoomVO);
            model.addAttribute("msgCode", "등록성공");
            return "redirect:mtRoomList";
        } else {
            model.addAttribute("msgCode", "등록실패! 확인 후 다시 시도해 주세요.");
            return "mtRoomRegist";
        }
    }
    
    @GetMapping(value = "/mtRoomDetail")
    public String getMtRoomView(@RequestParam("mrNo") int mrNo, Model model) throws Exception {
        MtRoomVO mtRoomVO = mtRoomService.getMTRoom(mrNo);
        model.addAttribute("mtRoomVO", mtRoomVO);
        return "mtRoomDetail";
    }
    
    @RequestMapping(value = "/deleteMtRoom", method = RequestMethod.GET)
    public String deleteMtRoom(@RequestParam("mrNo") int mrNo, Model model) throws Exception {
        if (this.mtRoomService.deleteMtRoom(mrNo) != 0) {
            model.addAttribute("errCode", 3);
            return "redirect:mtRoomList";
        } else {
            model.addAttribute("errCode", 5);
            return "redirect:mtRoomManage";
        }
    }
    
    @RequestMapping(value = "/updateMtRoom", method = RequestMethod.GET)
    public String getMtRoomUpView(@RequestParam("mrNo") int mrNo, Model model) throws Exception {
        MtRoomVO mtRoomVO = mtRoomService.getMTRoom(mrNo);
        model.addAttribute("mtRoomVO", mtRoomVO);
        return "mtRoomUpdate";
    }
    
    @RequestMapping(value = "/updateMtRoom", method = RequestMethod.POST)
    public String updateMtRoomOn(@ModelAttribute("mtRoomVO") MtRoomVO mtRoomVO, Model model, HttpSession session, MultipartHttpServletRequest mRequest) throws Exception {
        String userId = (String) session.getAttribute("userId");
        ServletContext servletContext = mRequest.getSession().getServletContext();
        String webappRoot = servletContext.getRealPath("/");
        String relativeFolder = File.separator + "resources" + File.separator + "images" + File.separator;

        mtRoomVO.setFirst_Reg_ID(userId);
        
        List<MultipartFile> fileList = mRequest.getFiles("file_1");

        for (MultipartFile mf : fileList) {
            if (!mf.isEmpty()) {
                String originFileName = mf.getOriginalFilename();
                mtRoomVO.setPicture(originFileName);
                String safeFile = webappRoot + relativeFolder + originFileName;

                try {
                    mf.transferTo(new File(safeFile));
                } catch (IllegalStateException | IOException e) {
                    e.printStackTrace();
                }
            }
        }

        if (this.mtRoomService.updateMtRoom(mtRoomVO) != 0) {
            model.addAttribute("mtRoomVO", mtRoomVO);
            model.addAttribute("errCode", 3);
            return "redirect:mtRoomList";
        } else {
            model.addAttribute("errCode", 5);
            return "mtRoomUpdate";
        }
    }

    @RequestMapping(value = "/searchMtRoom", method = RequestMethod.GET)
    public String searchMtRoom(@RequestParam("searchKeyword") String searchKeyword, Model model, HttpSession session) throws Exception {
        session.setAttribute("userId", "Test20");
        
        List<MtRoomVO> mtRoomList = mtRoomService.searchMtRoomByName(searchKeyword);
        model.addAttribute("mtRoomList", mtRoomList);
        
        return "mtRoomSearchResult";
    }
}
