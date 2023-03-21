package com.danim.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller
public class RestDocController {
    @GetMapping("/")
    public String restDoc(){
        return "/BOOT-INF/classes/static/index.html";
    }
}
