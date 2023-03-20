package com.danim.controller;

import com.danim.dto.InsertPostReq;
import com.danim.dto.InsertPostRes;
import com.danim.service.MultiPartServiceImpl;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/post")
@Slf4j
@AllArgsConstructor
public class MultiPartController {

    private final MultiPartServiceImpl multiPartService;
    @PostMapping(value = "/insert")
    public ResponseEntity<?> insertPost(
            InsertPostReq insertPostReq,
            @RequestPart(value = "photo", required=true) List<MultipartFile> photos
    ) throws  Exception{
        insertPostReq.setPhotos(new ArrayList<>(photos));
        System.out.println(insertPostReq);
        log.info("insertPost info : ",insertPostReq);
        InsertPostRes inserPostRes = multiPartService.insertPost(insertPostReq);
        return ResponseEntity.ok("ok");
    }
}
