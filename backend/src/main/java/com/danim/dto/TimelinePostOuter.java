package com.danim.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class TimelinePostOuter {
    private List<TimelinePostInner> Timeline;

    private List<String> NationList;

    public TimelinePostOuter() {
        Timeline = new ArrayList<>();

    }
}
