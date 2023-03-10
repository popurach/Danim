package com.danim.entity;

import lombok.*;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class Photo {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "photo_id", nullable = false)
    private Long photo_id;


    private double lat;


    private double lng;


    @Builder.Default
    @ColumnDefault("0")
    private Boolean is_live = false;


}
