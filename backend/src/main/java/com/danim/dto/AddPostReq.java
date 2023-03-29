package com.danim.dto;

import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Data
@NoArgsConstructor
@Getter
@Setter
@ToString
public class AddPostReq {
    @NotNull(message = "[Request] timelineId 값을 입력해주세요.")
    private Long timelineId;
    private Double lat;
    private Double lng;
    @NotNull(message = "[Request] address1 값을 입력해주세요.")
    private String address1;
    private String address2;
    private String address3;
    private String address4;
    }
