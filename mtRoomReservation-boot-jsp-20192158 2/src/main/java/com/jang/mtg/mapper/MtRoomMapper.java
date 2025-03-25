package com.jang.mtg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jang.mtg.model.MrResTimeVO;
import com.jang.mtg.model.MrReserveVO;
import com.jang.mtg.model.MtRoomVO;

@Mapper
public interface MtRoomMapper {

	List<MtRoomVO> getMtRoomList();
	MtRoomVO getMtRoom(int mrNo);
	
	int insertMtRoom(MtRoomVO mtRoomVO);
	int updateMtRoom(MtRoomVO mtRoomVO);
	int deleteMtRoom(int mrNo);

	List<MrReserveVO> getMrReserveList(MrResTimeVO mrResTimeVO);
	MrReserveVO getMrReserve(int reNo);
	int insertMrReserve(MrReserveVO mrReserveVO);
	int updateMrReserve(MrReserveVO mrReserveVO);
	int deleteMrReserve(int reNo);
	
	List<MtRoomVO> searchMtRoomByName(String name);


	int resDupCheck(MrReserveVO mrReserveVO);
	MrReserveVO getMrReserveByTime(MrReserveVO mrReserveVO);

}
