package com.yedam.myserver.emp.web;

import java.io.InputStream;
import java.sql.Connection;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;

@Controller
public class EmpPdfController {

	@Autowired BasicDataSource datasource;
	
	@RequestMapping("/report2.do")
	public String report2(@RequestParam(required = false, defaultValue = "10") String dept,
						  Model model) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("P_DEPT_ID", dept);
		model.addAttribute("param", map);
		model.addAttribute("filename", "/report/empList.jasper");
		return "pdfView";
	}
	
	@RequestMapping("/report.do")
	public void report(HttpServletRequest request,
					   HttpServletResponse response,
					   @RequestParam(required = false, defaultValue = "10") String dept) throws Exception {
		Connection conn = datasource.getConnection();
		//InputStream jasperStream = getClass().getResourceAsStream("/report/empList.jasper");
		//JasperReport jasperReport = (JasperReport) JRLoader.loadObject(jasperStream); // 파라미터 맵
		
		InputStream stream = getClass().getResourceAsStream("/report/empList.jrxml");
		JasperReport jasperReport = JasperCompileManager.compileReport(stream);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("P_DEPT_ID", dept);
		JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, map, conn);
		JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());
	}

}
