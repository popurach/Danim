package com.danim.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller
@Slf4j
public class RestDocController {
    private final String FILE_PATH = "/BOOT-INF/classes/static/index.html";
    private final String FILE_PATH1 = "/static/docs/index.html";


    @GetMapping("/1")
    public ClassPathResource restDoc(){
        ClassPathResource classPathResource = new ClassPathResource(FILE_PATH);
        if(classPathResource.exists()==false){
            log.info("invaild filepath :{}",FILE_PATH);
            throw new IllegalArgumentException();
        }
        log.info("file path exists = {}", classPathResource.exists());
        return classPathResource;
    }




    @GetMapping("/2")
    public ClassPathResource restDoc1() {
        ClassPathResource classPathResource = new ClassPathResource(FILE_PATH);
        if (classPathResource.exists() == false) {
            log.info("invaild filepath :{}", FILE_PATH);
            throw new IllegalArgumentException();
        }
        log.info("file path exists = {}", classPathResource.exists());
        return classPathResource;
    }
    @GetMapping("/3")
    public String restDocd(){
        return "**/index.html";
    }
}
