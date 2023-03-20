package com.danim.dto;

import lombok.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.multipart.MultipartFile;

import java.util.LinkedList;
import java.util.List;
@Getter
@Setter
@Builder
@Data
//@AllArgsConstructor
//@NoArgsConstructor
public class InsertPostReq {

//    @Value(value = "voice")
    MultipartFile voice;

    @Override
    public String toString() {
        return "InsertPostReq{" +
                "voice=" + voice +
                ", photos=" + photos +
                ", userUid=" + userUid +
                '}';
    }

    //    @Value(value = "photos")
    List<MultipartFile> photos;
//    @Value(value = "userUid")
    Long userUid;

}
