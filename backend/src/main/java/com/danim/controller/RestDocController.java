package com.danim.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller
public class RestDocController {
    @GetMapping("/1")
    public String restDoc(){
        return "/BOOT-INF/classes/static/index.html";
    }
    @GetMapping("/2")
    public String restDob(){
        return "/static/docs/index.html";
    }
    @GetMapping("/3")
    public String restDocd(){
        return "**/index.html";
    }
}
