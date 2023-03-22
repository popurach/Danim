package com.danim.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class TimelinePostOuter {
    private List<TimelinePostInner> Timeline;

}
