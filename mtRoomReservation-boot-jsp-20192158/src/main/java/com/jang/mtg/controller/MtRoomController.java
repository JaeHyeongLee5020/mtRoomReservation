package com.jang.mtg.controller;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Method;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jang.mtg.model.MrResTimeVO;
import com.jang.mtg.model.MrReserveVO;
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
        MtRoomVO mtRoomVO = mtRoomService.getMtRoom(mrNo);
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
        MtRoomVO mtRoomVO = mtRoomService.getMtRoom(mrNo);
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
    
    @RequestMapping(value="/mtResList")
    public String mrReserveList(@ModelAttribute("reserve_Day") String reserve_Day, Model model) throws Exception {
        
        // 현재 날짜로 초기화
        String strSearchDat;
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        strSearchDat = now.format(formatter);

        // reserve_Day가 null 또는 비어있는지 체크
        if (reserve_Day == null || reserve_Day.isEmpty()) {
            reserve_Day = strSearchDat;
        }

        // 회의실 목록과 예약 시간 목록 초기화
        List<MtRoomVO> mtRoomList = mtRoomService.getMtRoomList();
        List<MrResTimeVO> mrResTimeList = new ArrayList<>();

        // 각 회의실에 대해 예약 시간을 설정
        for (MtRoomVO mtRoom : mtRoomList) {
            MrResTimeVO mrResTimeVO1 = new MrResTimeVO();
            mrResTimeVO1.setReserve_Day(reserve_Day);
            mrResTimeVO1.setMrNo(mtRoom.getMrNo());
            mrResTimeVO1.setMr_Name(mtRoom.getMr_Name());

            // 회의실 예약 정보 가져오기
            List<MrReserveVO> mrDayReserveList = mtRoomService.getMrReserveList(mrResTimeVO1);

            for (MrReserveVO mrDayReserve : mrDayReserveList) {
                String sst = mrDayReserve.getReserve_Start().replace(":", "");
                String set = mrDayReserve.getReserve_End().replace(":", "");
                int st = Integer.parseInt(sst);
                int et = Integer.parseInt(set);

                // 예약 시작과 끝 시간을 기준으로 시간 간격 설정
                
                for (int i = st; i <= et; i += 50) {
                    int num = (i % 100 > 30) ? i - 20 : i;
                    if (num % 100 == 60) {
                        num += 40;
                    }

                    String resveTn = "setResveTemp" + num;
                    try {
                        Method m = MrResTimeVO.class.getMethod(resveTn, String.class);
                        if (m != null) {
                            m.invoke(mrResTimeVO1, "1");
                        }
                    } catch (NoSuchMethodException e) {
                        System.out.println("Method not found: " + resveTn);
                        e.printStackTrace();
                    } catch (Exception e) {
                        System.out.println("An error occurred while invoking the method: " + resveTn);
                        e.printStackTrace();
                    }
                }

            }
            mrResTimeList.add(mrResTimeVO1);
        }

        // 모델에 데이터 추가
        model.addAttribute("mrResTimeList", mrResTimeList);
        model.addAttribute("reserve_Day", reserve_Day);

        return "mtResList";
    }

    @RequestMapping(value="/insertReserve",method = RequestMethod.POST)
    public String insertResOn(@ModelAttribute("mrReserveVO") MrReserveVO mrReserveVO,Model model, HttpSession session
    		,RedirectAttributes rea) throws Exception{
    	
    	String userId = (String)session.getAttribute("userId");
    	
    	mrReserveVO.setFirst_Reg_ID(userId);
    	mrReserveVO.setBookerID(userId);
    	
    	if(this.mtRoomService.insertMrReserve(mrReserveVO) != 0) {
    		
    		rea.addFlashAttribute("reserve_Day", mrReserveVO.getReserve_Day());
    		return "redirect:mtResList";
    	}else {
    		model.addAttribute("errerCode",5);
    		return "mtResRegist";
    		
    	}
    	
    }
    @RequestMapping(value = "/mtResRegist",method = RequestMethod.POST)
    public String insertResView(@ModelAttribute("mrReserveVO") MrReserveVO mrReserveVO,Model model, HttpSession session
    		) throws Exception{
    
    	int intValue1 = Integer.parseInt(mrReserveVO.getReserve_Start())+100;
    	String endTime = Integer.toString(intValue1);
    	mrReserveVO.setReserve_End(endTime);
    	
    	session.setAttribute("userId", "Test20");
    	String userId = (String) session.getAttribute("userId");
    	mrReserveVO.setBookerID(userId);
    	
    	MtRoomVO mtRoomVO = mtRoomService.getMtRoom(mrReserveVO.getMrNo());
    	
    	model.addAttribute("mtRoomVO",mtRoomVO);
    	model.addAttribute("mrReserveVO",mrReserveVO);
    
    	return "mtResRegist";
    }
    
    @RequestMapping(value = "/updateResView", method = RequestMethod.POST)
    public String updateResView(@ModelAttribute("mrReserveVO") MrReserveVO mrReserveVO, Model model, HttpSession session) throws Exception {
        System.out.println("updateResView 메서드 호출됨");  // 로그 추가
        session.setAttribute("userId", "Test20");
        
        MrReserveVO mrReserveVO1 = mtRoomService.getMrReserveByTime(mrReserveVO);
        MtRoomVO mtRoomVO = mtRoomService.getMtRoom(mrReserveVO.getMrNo());
        
        model.addAttribute("mtRoomVO", mtRoomVO);
        model.addAttribute("mrReserveVO", mrReserveVO1);
        
        return "mtResUpdate";
    }

    
    @RequestMapping(value = "/updateReserve", method = RequestMethod.POST)
    public String updateReserve(@ModelAttribute("mrReserveVO") MrReserveVO mrReserveVO, RedirectAttributes rea) throws Exception {
        LocalDate now = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        String strSearchDay = now.format(formatter);
        
        mrReserveVO.setLast_Reg_ID(mrReserveVO.getBookerID());
        mrReserveVO.setLast_Reg_Date(strSearchDay);

        // 디버깅용 출력
        System.out.println("Updating reserve with details: " + mrReserveVO.toString());

        int updateResult = this.mtRoomService.updateMrReserve(mrReserveVO);
        if (updateResult != 0) {
            rea.addFlashAttribute("reserve_Day", mrReserveVO.getReserve_Day());
            return "redirect:/mtResList";
        } else {
            rea.addFlashAttribute("errCode", 5);
            rea.addFlashAttribute("reserve_Day", mrReserveVO.getReserve_Day());
            return "redirect:/mtResList";
        }
    }

    
    @RequestMapping(value = "/deleteReserve", method = RequestMethod.POST)
    public String deleteRes(@ModelAttribute("mrReserveVO") MrReserveVO mrReserveVO,RedirectAttributes rea) throws Exception{
    
    	int reNo = mrReserveVO.getReNo();
    	
    	if(this.mtRoomService.deleteMrReserve(reNo)!=0) {
    		
    		rea.addFlashAttribute("reserve_Day",mrReserveVO.getReserve_Day());
    		return "redirect:/mtResList";
    	}else {
    		rea.addFlashAttribute("errCode",5);
    		rea.addFlashAttribute("reserve_Day",mrReserveVO.getReserve_Day());
    		return "redirect:/mtResList";
    	}
    } 
    
    
    
    
    
    
    
    
}
