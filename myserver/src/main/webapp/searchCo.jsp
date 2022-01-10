<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>업체검색</h3>
<a href="#">애플</a><br>
<a href="#">삼성</a><br>
<a href="#">LG</a><br>
<a href="#">현대</a><br>
<a href="#">SK</a>
<script type="text/javascript">
	$("a").on("click", function() {
		var co = $(this).html();
		$("#txtCo").val(co);
		dialog.dialog("close");
	})
</script>
</body>
</html>