package com.danim.exception;

import lombok.Data;
import org.springframework.http.HttpStatus;


//에러 코드와 메시지를 같이 넘겨 주기 위해 선언이 된 class이다
@Data
public class BaseException extends RuntimeException {
    //private int errorCode;
    private String errorMessage;
    private HttpStatus httpStatus;


    public BaseException(ErrorMessage errorMessage) {
        this.errorMessage = errorMessage.getErrMsg();
        this.httpStatus = errorMessage.getHttpStatus();
    }



    public HttpStatus getHttpStatus() {
        return httpStatus;
    }

    public String getErrorMessage() {
        return errorMessage;
    }


}