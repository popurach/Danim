package com.danim.dto;

import com.danim.exception.BaseException;
import com.danim.exception.ErrorMessage;
import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Data
@NoArgsConstructor
@Getter
@Setter
@ToString
public class InsertPostReq {
    private Long timelineId;
    private Double lat;
    private Double lng;
    private String address1;
    private String address2;
    private String address3;
    private String address4;

    public void validate() {
        if (timelineId == null || address1 == null) {
            throw new BaseException(ErrorMessage.VALIDATION_FAIL_EXCEPTION);
        }
    }
}
