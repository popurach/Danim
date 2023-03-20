package com.danim.dto;

import com.danim.entity.Nation;
import com.danim.entity.Photo;
import com.danim.entity.TimeLine;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class InsertPostRes {
    Long postId;

    String voiceUrl;

    Long voiceLength;

    String nationUrl;

    String address;

    String text;

    TimeLine timelineId;

    Nation nationId;

    List<Photo> photoList = new ArrayList<>();
}
