package com.yedam.myserver.city;

import java.util.List;

import lombok.Data;

@Data
public class ModifyVO {

	List<CityVO> createdRows;
	List<CityVO> updatedRows;
	List<CityVO> deletedRows;
}
