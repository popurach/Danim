package com.danim.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SignInResult extends SignUpResult{
    private String accessToken;

    private String refreshToken;

    @Builder
    public SignInResult(boolean success, int code, String msg, String accessToken, String refreshToken){
        super(success, code, msg);
        this.accessToken = accessToken;
        this.refreshToken = refreshToken;
    }
}
