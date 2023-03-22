package com.danim.config;

import com.danim.exception.BaseException;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestControllerAdvice
public class GlobalExceptionHandler {

    // private static Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(BaseException.class)
    public ResponseEntity<?> baseHandler(BaseException e) {
        Map<String, Object> result = new HashMap<>();
        if (e.getErrorCode() != 0) {
            result.put("msg", e.getErrorMessage());
        }
        return new ResponseEntity<Object>(result, e.getHttpStatus());
    }


    @NoArgsConstructor
    @AllArgsConstructor
    static class Error {
        private int code;
        private HttpStatus status;
        private List<String> message;


        static Error create(BaseException exception) {
            return new Error(exception.getErrorCode(), exception.getHttpStatus(), exception.getErrorMessage());
        }

        public int getCode() {
            return code;
        }

        public HttpStatus getStatus() {
            return status;
        }

        public List<String> getMessage() {
            return message;
        }


    }


}
