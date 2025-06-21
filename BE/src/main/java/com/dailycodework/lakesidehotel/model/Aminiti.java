package com.dailycodework.lakesidehotel.model;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.LongStream.LongMapMultiConsumer;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Entity
@Setter
@Getter
@AllArgsConstructor
public class Aminiti {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private boolean ac = false;;
    private boolean tv = false;;
    private boolean miniBar = false;;
    private boolean balcony = false;;
    private boolean jacuzzi = false;;
    private boolean kitchen = false;;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "room_id")
    private Room room;

}
