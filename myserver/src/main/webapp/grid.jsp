<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>

<body>
<div class="modal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Modal title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>Modal body text goes here.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
	<h1>그리드</h1>
	<input id="txtCo"><button type="button" id="btnFindCo">업체검색</button><br>
	<input id="txtEmp"><button type="button" id="btnFindEmp">사원검색</button>
	<br>
	<div id="dialog-form" title="MODAL">test</div>
	<div style="float: right;">
		<button type="button" id="btnFind">조회</button>
		<button type="button" id="btnRst">초기화</button>
		<button type="button" id="btnAdd">추가</button>
		<button type="button" id="btnDel">삭제</button>
		<button type="button" id="btnSave">저장</button>
	</div>
	<br>
	<div id="grid"></div>

	<script type="text/javascript">
		function selectCo(co){
			$("#txtCo").val(co);
			dialog.dialog("close");
		}
		
		let dialog = $( "#dialog-form" ).dialog({
			modal:true,	// 모달이외 제어불가
			autoOpen: false,
		    height: 400,
		    width: 350,
		    buttons: {"save":function(){
	    								alert("save");
	    								dialog.dialog("close");
	    							}, 
		    		  "upd":function(){alert("update");
		    		  				   dialog.dialog("close");
		    		  				}
		    }
		});
		
		$("#btnFindCo").on("click", function(){
			dialog.dialog("open");
			$("#dialog-form").load("searchCo.jsp",function(){console.log("로드됨")})
		});
		
		
		
		var Grid = tui.Grid;
		Grid.applyTheme('striped', {
			cell: {
				header: {
					background: '#eef'
				},
				evenRow: {
					background: '#fee'
				}
			},
			frozenBorder: {
				border: '#ff0000'
			}
		});
		const columns = [{
				header: 'ID',
				name: 'id'
			},
			{
				header: 'CITY',
				name: 'city',
				editor: 'text'
			},
			{
				header: 'COUNTRY',
				name: 'country'
			},
			{
				header: 'DATE',
				name: 'date',
				editor: 'datePicker'
			},
			{
				header: 'BROWSER',
				name: 'browser',
				formatter: 'listItemText',
				editor: {
					type: 'select',
					options: {
						listItems: [{
								text: 'IE 9',
								value: 1
							},
							{
								text: 'IE 10',
								value: 2
							},
							{
								text: 'IE 11',
								value: 3
							},
							{
								text: 'Firefox',
								value: 4
							},
							{
								text: 'Chrome',
								value: 5
							}
						]
					}
				}
			}
		];

		let data;

		//ajax요청
		// $.ajax({
		// 	url: '${pageContext.request.contextPath}/resources/json/city.json',
		//	data: {},
		// 	dataType: 'json',
		// 	async: false
		// }).done(function(datas){
		// 	data = datas;
		// });

		const dataSource = {
			api: {
				readData: {
					url: '${pageContext.request.contextPath}/resources/json/city.json',
					method: 'GET',
					initParams: {
						param: 'param'
					}
				},
				modifyData: {
					url: '${pageContext.request.contextPath}/modifyData',
					method: 'PUT'
				}
			},
			contentType: 'application/json'
		};

		const grid = new Grid({
			el: document.getElementById('grid'),
			data: dataSource,
			rowHeaders: ['checkbox'],
			columns,
			columnOptions: {
				frozenCount: 2, // 2개의 컬럼을 고정하고
				frozenBorderWidth: 2 // 고정 컬럼의 경계선 너비를 2px로 한다.
			}
		});

		grid.on("click", (ev) => {
			console.log(ev);
			console.log("checked!!!!");
		});
		
		grid.on('response', function (ev) {
			// 성공/실패와 관계 없이 응답을 받았을 경우
			console.log("1111");
			//console.log(ev);
			/* grid.resetOriginData(); */
		});

		btnFind.addEventListener("click", function(){
			
		});
		btnAdd.addEventListener("click", function(){
			grid.appendRow();
		});
		btnDel.addEventListener("click", function(){
			grid.removeCheckedRows(true);
		});
		btnSave.addEventListener("click", function(){
			grid.request('modifyData');
		});
	</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>

</html>