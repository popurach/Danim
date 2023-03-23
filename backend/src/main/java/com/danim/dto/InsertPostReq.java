package com.danim.dto;

import lombok.*;

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
}
