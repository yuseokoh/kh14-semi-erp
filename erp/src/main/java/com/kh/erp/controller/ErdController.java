package com.kh.erp.controller;


import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.erp.dao.ChangeLogDao;
import com.kh.erp.dao.ErdDao;
import com.kh.erp.dto.ChangeLogDto;
import com.kh.erp.dto.ErdDto;
import com.kh.erp.service.ChangeLogService;

import jakarta.annotation.PostConstruct;

@Controller
@RequestMapping("/stock")
public class ErdController {

    @Autowired
    private ErdDao erdDao;
    
    @Autowired
    private ChangeLogService changeLogService;

    
    @Autowired
    private ChangeLogDao changeLogDao; // ChangeLogDao 추가
    

    @Value("${file.upload-dir}")
    private String uploadDir;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        // 날짜 포맷을 설정합니다.
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
        
        // 여기에 다른 타입의 CustomEditor를 추가 설정할 수 있습니다.
        // 예를 들어, 다른 데이터 타입을 추가로 설정하려면 다음과 같이 작성합니다.
        // binder.registerCustomEditor(AnotherType.class, new AnotherCustomEditor());
    }

    @PostConstruct
    public void init() {
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdirs(); // 디렉토리가 없으면 생성
        }
    }

    // 등록 페이지
    @GetMapping("/insert")
    public String insert() {
        return "/WEB-INF/views/stock/insert.jsp";
    }

    // 등록 처리
    @PostMapping("/insert")
    public String insert(@ModelAttribute ErdDto erdDto,
                         @RequestParam("image") MultipartFile image,
                         RedirectAttributes redirectAttributes) {
        try {
            // 이미지 파일 처리
            String imageUrl = saveUploadedFile(image);
            erdDao.insert(erdDto, imageUrl);
        } catch (Exception e) {
            e.printStackTrace();  // 로그에 에러 기록
            redirectAttributes.addAttribute("error", true);
            return "redirect:/stock/insert";
        }
        return "redirect:/stock/list3";
    }

    // 이미지 파일을 서버에 저장하고 URL을 반환합니다.
    private String saveUploadedFile(MultipartFile file) throws IOException {
        if (file.isEmpty()) {
            throw new IOException("파일이 비어 있습니다.");
        }

        String originalFilename = file.getOriginalFilename();
        String fileName = System.currentTimeMillis() + "_" + originalFilename;
        File destinationFile = new File(uploadDir + File.separator + fileName);

        try {
            file.transferTo(destinationFile);

            if (!destinationFile.exists()) {
                throw new IOException("파일 저장에 실패했습니다.");
            }

            System.out.println("파일이 성공적으로 저장되었습니다: " + destinationFile.getAbsolutePath());
        } catch (IOException e) {
            System.err.println("파일 저장 중 예외 발생: " + e.getMessage());
            throw e;
        }

        return fileName; // 이미지 URL이 아닌 파일 이름을 반환
    }
    
 // 파일을 웹에서 접근할 수 있도록 하는 메서드
    @RequestMapping(value = "/uploaded-images", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<Resource> serveFile(@RequestParam("filename") String filename) {
        try {
            // 파일 경로를 생성하고 정규화합니다
            Path filePath = Paths.get(uploadDir).resolve(filename).normalize();
            File file = filePath.toFile();
            
            // 파일을 URL 리소스로 변환합니다
            Resource resource = new UrlResource(file.toURI());

            // 파일이 존재하고 읽을 수 있는지 확인합니다
            if (resource.exists() || resource.isReadable()) {
                // 파일이 유효한 경우, HTTP 200 OK 상태 코드와 함께 파일을 응답 본문으로 반환합니다
                return ResponseEntity.ok()
                        .contentType(MediaType.IMAGE_JPEG)  // 적절한 MIME 타입으로 설정 (여기서는 JPEG 이미지)
                        .body(resource);
            } else {
                // 파일이 존재하지 않거나 읽을 수 없는 경우, HTTP 404 Not Found 상태 코드 반환
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
            }
        } catch (IOException e) {
            // 파일 처리 중 예외가 발생한 경우, HTTP 500 Internal Server Error 상태 코드 반환
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // 등록 완료 페이지
    @RequestMapping("/insertComplete")
    public String insertComplete() {
        return "/WEB-INF/views/stock/insertComplete.jsp";
    }

 // 목록(검색) 페이지
    @RequestMapping("/list3")
    public String list(Model model,
                       @RequestParam(required = false) String column,
                       @RequestParam(required = false) String keyword) {
        List<ErdDto> list = null;
        Map<Integer, ChangeLogDto> latestChangeLogsMap = new HashMap<>(); // 최신 변경 로그를 저장할 맵
        
        try {
            boolean isSearch = column != null && keyword != null;
            list = isSearch ? erdDao.selectList(column, keyword) : erdDao.selectList();

            // 각 재고 번호에 대해 최신 변경 로그를 조회
            for (ErdDto stock : list) {
                List<ChangeLogDto> changeLogs = changeLogDao.selectChangeLogsByStockNo(stock.getStockNo());
                ChangeLogDto latestChangeLog = changeLogs.isEmpty() ? new ChangeLogDto() : changeLogs.get(0);
                latestChangeLogsMap.put(stock.getStockNo(), latestChangeLog);
            }

        } catch (Exception e) {
            e.printStackTrace();  // 로그에 에러 기록
            return "redirect:/stock/list?error=true";
        }

        model.addAttribute("column", column);
        model.addAttribute("keyword", keyword);
        model.addAttribute("list", list);
        model.addAttribute("latestChangeLogsMap", latestChangeLogsMap); // 최신 변경 로그 맵을 모델에 추가
        return "/WEB-INF/views/stock/list3.jsp";
    }




    // 상세 조회 페이지
    @RequestMapping("/detail")
    public String detail(@RequestParam(name = "stockNo", required = false) Integer stockNo, Model model) {
        if (stockNo == null || stockNo <= 0) {
            return "redirect:/stock/list?error=true";
        }

        ErdDto dto = null;
        try {
            dto = erdDao.selectOne(stockNo);
        } catch (Exception e) {
            e.printStackTrace();  // 로그에 에러 기록
            return "redirect:/stock/list?error=true";
        }

        if (dto == null) {
            return "redirect:/stock/list?error=true";
        }

        model.addAttribute("dto", dto);
        return "/WEB-INF/views/stock/detail.jsp";
    }

    // 삭제 처리
    @RequestMapping("/delete")
    public String delete(@RequestParam int stockNo) {
        try {
            erdDao.delete(stockNo);
        } catch (Exception e) {
            e.printStackTrace();  // 로그에 에러 기록
            return "redirect:/stock/list?error=true";
        }
        return "redirect:/stock/list3";
    }

    // 수정(입력) 페이지
    @GetMapping("/edit")
    public String edit(Model model, @RequestParam int stockNo) {
        ErdDto dto = null;
        try {
            dto = erdDao.selectOne(stockNo);
        } catch (Exception e) {
            e.printStackTrace();  // 로그에 에러 기록
            return "redirect:/stock/list?error=true";
        }

        if (dto == null) {
            return "redirect:/stock/list?error=true";
        }

        model.addAttribute("dto", dto);
        return "/WEB-INF/views/stock/edit.jsp";
    }

    // 수정 처리
    @PostMapping("/edit")
    public String edit(@ModelAttribute ErdDto dto,
                       @RequestParam(value = "image", required = false) MultipartFile image) {
        try {
            // 새 이미지가 업로드된 경우 처리
            String imageUrl = null;
            if (image != null && !image.isEmpty()) {
                imageUrl = saveUploadedFile(image); // 새 이미지 저장
            } else {
                // 새 이미지가 없을 경우 기존 이미지 URL을 유지
                ErdDto existingDto = erdDao.selectOne(dto.getStockNo());
                imageUrl = existingDto.getImageUrl();
            }

            // 기존의 유통기한 값을 유지
            ErdDto existingDto = erdDao.selectOne(dto.getStockNo());
            if (dto.getExpirationDate() == null) {
                dto.setExpirationDate(existingDto.getExpirationDate());
            }

            // 재고 정보를 업데이트합니다.
            boolean result = erdDao.update(dto, imageUrl);
            if (!result) {
                return "redirect:/stock/edit?stockNo=" + dto.getStockNo() + "&error=true";
            }
        } catch (Exception e) {
            e.printStackTrace();  // 로그에 에러 기록
            return "redirect:/stock/edit?stockNo=" + dto.getStockNo() + "&error=true";
        }
        return "redirect:/stock/detail?stockNo=" + dto.getStockNo();
    }

    @PostMapping("/increaseQuantity")
    public String increaseQuantity(@RequestParam int stockNo, @RequestParam int amount, RedirectAttributes redirectAttributes) {
        try {
            ErdDto existingDto = erdDao.selectOne(stockNo);
            if (existingDto == null) {
                redirectAttributes.addFlashAttribute("error", "해당 상품을 찾을 수 없습니다.");
                return "redirect:/stock/list";
            }

            // 현재 재고 수량을 저장
            int oldQuantity = existingDto.getStockQuantity();
            int newQuantity = oldQuantity + amount;
            existingDto.setStockQuantity(newQuantity);
            erdDao.updateQuantity(existingDto); // 수량 업데이트

            // 변경된 필드 정보 및 Old/ New Values 생성
            String changedFields = String.format("입고", amount);
            String oldValues = String.format("Quantity: %d", oldQuantity);
            String newValues = String.format("Quantity: %d", newQuantity);
            
            // 변경 로그를 추가합니다.
            changeLogDao.insertChangeLog(stockNo, changedFields, oldValues, newValues);
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "입고 처리 중 오류가 발생했습니다.");
            return "redirect:/stock/detail?stockNo=" + stockNo;
        }
        return "redirect:/stock/detail?stockNo=" + stockNo;
    }

    @PostMapping("/decreaseQuantity")
    public String decreaseQuantity(@RequestParam int stockNo, @RequestParam int amount, RedirectAttributes redirectAttributes) {
        try {
            ErdDto existingDto = erdDao.selectOne(stockNo);
            if (existingDto == null) {
                redirectAttributes.addFlashAttribute("error", "해당 상품을 찾을 수 없습니다.");
                return "redirect:/stock/list";
            }

            // 현재 재고 수량을 저장
            int oldQuantity = existingDto.getStockQuantity();
            int newQuantity = oldQuantity - amount;
            if (newQuantity < 0) {
                redirectAttributes.addFlashAttribute("error", "재고 수량이 부족합니다.");
                return "redirect:/stock/detail?stockNo=" + stockNo;
            }
            existingDto.setStockQuantity(newQuantity);
            erdDao.updateQuantity(existingDto); // 수량 업데이트

            // 변경된 필드 정보 및 Old/ New Values 생성
            String changedFields = String.format("출고", amount);
            String oldValues = String.format("Quantity: %d", oldQuantity);
            String newValues = String.format("Quantity: %d", newQuantity);
            
            // 변경 로그를 추가합니다.
            changeLogDao.insertChangeLog(stockNo, changedFields, oldValues, newValues);
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "출고 처리 중 오류가 발생했습니다.");
            return "redirect:/stock/detail?stockNo=" + stockNo;
        }
        return "redirect:/stock/detail?stockNo=" + stockNo;
    }
    
    
 // 전체 변경 로그를 조회하는 메서드 추가
    @RequestMapping("/changeLogList")
    public String changeLogList(Model model) {
        try {
            // 전체 변경 로그를 조회
            List<ChangeLogDto> changeLogList = changeLogService.getAllChangeLogs();
            model.addAttribute("changeLogList", changeLogList);
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/stock/list?error=true";
        }
        return "/WEB-INF/views/stock/changeLogList.jsp";
    }
    
    
    @RequestMapping("/categoryQuantity")
    public String categoryQuantity(Model model) {
        try {
            // 모든 상품 조회
            List<ErdDto> allProducts = erdDao.selectList(); // 기존 메서드 사용

            // 카테고리별 수량 집계
            Map<String, Integer> categoryMap = new HashMap<>();
            for (ErdDto product : allProducts) {
                String category = product.getStockCategory(); // 카테고리
                int quantity = product.getStockQuantity(); // 수량
                categoryMap.put(category, categoryMap.getOrDefault(category, 0) + quantity);
            }

            // Map을 JSON 문자열로 변환
            String categoryMapJson = new ObjectMapper().writeValueAsString(categoryMap);
            model.addAttribute("categoryMapJson", categoryMapJson);
        } catch (Exception e) {
            e.printStackTrace(); // 로그에 에러 기록
            return "redirect:/stock/list?error=true";
        }
        return "/WEB-INF/views/stock/categoryQuantity.jsp";
    }
    
}
