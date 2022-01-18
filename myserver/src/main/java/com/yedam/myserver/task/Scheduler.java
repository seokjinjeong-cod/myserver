package com.yedam.myserver.task;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class Scheduler {

	//@Autowired 서비스
	
	@Scheduled(fixedDelay = 5000)
	public void task1() {
		System.out.println("task1");
	}
	
	@Scheduled(cron = "0/10 0-10 10,12 * * *")
	public void task2() {
		System.out.println("task2");
	}
}
