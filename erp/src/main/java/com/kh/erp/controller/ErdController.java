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
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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
    private ChangeLogDao changeLogDao;

    @Value("${file.upload-dir}")
    private String uploadDir;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    @PostConstruct
    public void init() {
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdirs();
        }
    }

    @GetMapping("/insert")
    public String insert() {
        return "/WEB-INF/views/stock/insert.jsp";
    }

    @PostMapping("/insert")
    public String insert(@ModelAttribute ErdDto erdDto,
                         @RequestParam("image") MultipartFile image,
                         RedirectAttributes redirectAttributes) {
        try {
            String imageUrl = saveUploadedFile(image);
            erdDao.insert(erdDto, imageUrl);
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addAttribute("error", true);
            return "redirect:/stock/insert";
        }
        return "redirect:/stock/insertComplete";
    }

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
        } catch (IOException e) {
            System.err.println("파일 저장 중 예외 발생: " + e.getMessage());
            throw e;
        }

        return fileName;
    }

    @RequestMapping(value = "/uploaded-images", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<Resource> serveFile(@RequestParam("filename") String filename) {
        try {
            Path filePath = Paths.get(uploadDir).resolve(filename).normalize();
            File file = filePath.toFile();
            Resource resource = new UrlResource(file.toURI());

            if (resource.exists() || resource.isReadable()) {
                return ResponseEntity.ok()
                        .contentType(MediaType.IMAGE_JPEG)
                        .body(resource);
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
            }
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @RequestMapping("/insertComplete")
    public String insertComplete() {
        return "/WEB-INF/views/stock/insertComplete.jsp";
    }

    @RequestMapping("/list")
    public String list(Model model,
                       @RequestParam(required = false) String column,
                       @RequestParam(required = false) String keyword,
                       @RequestParam(defaultValue = "1") int page,
                       @RequestParam(defaultValue = "10") int size) {
        List<ErdDto> list = null;
        Map<Integer, ChangeLogDto> latestChangeLogsMap = new HashMap<>();

        try {
            // 페이지 번호와 사이즈의 유효성 검증
            if (page < 1) page = 1;
            if (size < 1) size = 10;

            Pageable pageable = PageRequest.of(page - 1, size, Sort.by(Sort.Order.asc("stockNo")));

            Page<ErdDto> pageResult;
            if (column != null && keyword != null) {
                // 검색 기능이 활성화된 경우
                pageResult = erdDao.selectList(column, keyword, pageable);
            

            list = pageResult.getContent();
            int totalPages = pageResult.getTotalPages();
            long totalItems = pageResult.getTotalElements();

            // 최신 ChangeLog를 가져오기
            for (ErdDto stock : list) {
                List<ChangeLogDto> changeLogs = changeLogDao.selectChangeLogsByStockNo(stock.getStockNo());
                ChangeLogDto latestChangeLog = changeLogs.isEmpty() ? new ChangeLogDto() : changeLogs.get(0);
                latestChangeLogsMap.put(stock.getStockNo(), latestChangeLog);
            }

            model.addAttribute("column", column);
            model.addAttribute("keyword", keyword);
            model.addAttribute("list", list);
            model.addAttribute("latestChangeLogsMap", latestChangeLogsMap);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("totalItems", totalItems);
            }
        }

         catch (Exception e) {
            e.printStackTrace();
            // 오류가 발생한 경우 사용자에게 피드백을 제공
            model.addAttribute("error", "데이터를 가져오는 중 오류가 발생했습니다.");
            return "/WEB-INF/views/stock/error.jsp"; // 에러 페이지로 리디렉션
        }

        return "/WEB-INF/views/stock/list.jsp";
    }


    @RequestMapping("/detail")
    public String detail(@RequestParam(name = "stockNo", required = false) Integer stockNo, Model model) {
        if (stockNo == null || stockNo <= 0) {
            return "redirect:/stock/list?error=true";
        }

        ErdDto dto = null;
        try {
            dto = erdDao.selectOne(stockNo);
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/stock/list?error=true";
        }

        if (dto == null) {
            return "redirect:/stock/list?error=true";
        }

        model.addAttribute("dto", dto);
        return "/WEB-INF/views/stock/detail.jsp";
    }

    @RequestMapping("/delete")
    public String delete(@RequestParam int stockNo) {
        try {
            erdDao.delete(stockNo);
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/stock/list?error=true";
        }
        return "redirect:/stock/list";
    }

    @GetMapping("/edit")
    public String edit(Model model, @RequestParam int stockNo) {
        ErdDto dto = null;
        try {
            dto = erdDao.selectOne(stockNo);
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/stock/list?error=true";
        }

        if (dto == null) {
            return "redirect:/stock/list?error=true";
        }

        model.addAttribute("dto", dto);
        return "/WEB-INF/views/stock/edit.jsp";
    }

    @PostMapping("/edit")
    public String edit(@ModelAttribute ErdDto dto,
                       @RequestParam(value = "image", required = false) MultipartFile image) {
        try {
            String imageUrl = null;
            if (image != null && !image.isEmpty()) {
                imageUrl = saveUploadedFile(image);
            } else {
                ErdDto existingDto = erdDao.selectOne(dto.getStockNo());
                imageUrl = existingDto.getImageUrl();
            }

            boolean result = erdDao.update(dto, imageUrl);
            if (!result) {
                return "redirect:/stock/edit?stockNo=" + dto.getStockNo() + "&error=true";
            }
        } catch (Exception e) {
            e.printStackTrace();
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

            int oldQuantity = existingDto.getStockQuantity();
            int newQuantity = oldQuantity + amount;
            existingDto.setStockQuantity(newQuantity);
            erdDao.updateQuantity(existingDto);

            String changedFields = String.format("입고", amount);
            String oldValues = String.format("Quantity: %d", oldQuantity);
            String newValues = String.format("Quantity: %d", newQuantity);

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

            int oldQuantity = existingDto.getStockQuantity();
            int newQuantity = oldQuantity - amount;
            if (newQuantity < 0) {
                redirectAttributes.addFlashAttribute("error", "재고 수량이 부족합니다.");
                return "redirect:/stock/detail?stockNo=" + stockNo;
            }
            existingDto.setStockQuantity(newQuantity);
            erdDao.updateQuantity(existingDto);

            String changedFields = String.format("출고", amount);
            String oldValues = String.format("Quantity: %d", oldQuantity);
            String newValues = String.format("Quantity: %d", newQuantity);

            changeLogDao.insertChangeLog(stockNo, changedFields, oldValues, newValues);
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "출고 처리 중 오류가 발생했습니다.");
            return "redirect:/stock/detail?stockNo=" + stockNo;
        }
        return "redirect:/stock/detail?stockNo=" + stockNo;
    }

    @RequestMapping("/changeLogList")
    public String changeLogList(Model model) {
        try {
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
            List<ErdDto> allProducts = erdDao.selectList();
            Map<String, Integer> categoryMap = new HashMap<>();
            for (ErdDto product : allProducts) {
                String category = product.getStockCategory();
                int quantity = product.getStockQuantity();
                categoryMap.put(category, categoryMap.getOrDefault(category, 0) + quantity);
            }

            String categoryMapJson = new ObjectMapper().writeValueAsString(categoryMap);
            model.addAttribute("categoryMapJson", categoryMapJson);
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/stock/list?error=true";
        }
        return "/WEB-INF/views/stock/categoryQuantity.jsp";
    }
}
