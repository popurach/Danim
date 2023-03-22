package com.danim.exception;

import lombok.Data;
import org.springframework.http.HttpStatus;

import java.util.ArrayList;
import java.util.List;


//에러 코드와 메시지를 같이 넘겨 주기 위해 선언이 된 class이다
@Data
public class BaseException extends RuntimeException {
    private int errorCode;
    private List<String> errorMessage;
    private HttpStatus httpStatus;
    

    public BaseException(ErrorMessage errorMessage) {
        this.errorCode = errorMessage.getCode();
        this.errorMessage = new ArrayList<>();
        this.errorMessage.add(errorMessage.getErrMsg());
        this.httpStatus = errorMessage.getHttpStatus();
    }

    public int getErrorCode() {
        return errorCode;
    }

    public HttpStatus getHttpStatus() {
        return httpStatus;
    }

    public List<String> getErrorMessage() {
        return errorMessage;
    }






}