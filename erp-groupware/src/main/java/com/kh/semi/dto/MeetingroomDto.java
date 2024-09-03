package com.kh.semi.dto;

import lombok.Data;

@Data
public class MeetingroomDto {
	private int roomId;
	private String roomName;
	private String location;
	private int capacity;
	private String projector;
	private String whiteboard;
	private String monitor;
	private String faultyEquipmentInfo;
}
