package com.danim.dto;

import com.danim.exception.BaseException;
import com.danim.exception.ErrorMessage;
import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotNull;
import java.util.List;

@Data
@NoArgsConstructor
@Getter
@Setter
@ToString
public class InsertPostReq {
    @NotNull
    private Long timelineId;
    @NotNull
    private Double lat;
    @NotNull
    private Double lng;
    @NotNull
    private String address1;
    @NotNull
    private String address2;
    @NotNull
    private String address3;
    @NotNull
    private String address4;
    }
