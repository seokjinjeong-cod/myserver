package com.yedam.myserver.city;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CityController {

	@PutMapping("/modifyData")
	@ResponseBody
	public boolean modifyData(@RequestBody ModifyVO mvo) {
		System.out.println(mvo);
		
//		for(CityVO vo : mvo.getCreatedRows()) {
//			service.insert(vo);
//		}// controller 말고 service에서 해야함
		
		return true;
	}
}
