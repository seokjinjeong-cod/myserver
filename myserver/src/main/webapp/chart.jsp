<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <!--Load the AJAX API-->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
		var seq = null;
      // Load the Visualization API and the corechart package.
      google.charts.load('current', {'packages':['corechart']});

      // Set a callback to run when the Google Visualization API is loaded.
      google.charts.setOnLoadCallback(initChart);

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
        // Create the data table.
        // Set chart options

      
      function initChart() {
        var options = {'title':'온도체크',
                'width':400,
                'height':300};
        
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'DT');
        data.addColumn('number', 'TEMP');
        data.addRows([ ]);
        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
        chart.draw(data, options);
        
	 	function drawChart() {
	        $.ajax({
	        	url : "./findTemp", 
	        	data : {seq : seq},
	        	type : "json", 
	        	async : false,
	        	success : function(result) {    
	        		//ajax결과를 chart에 맞는 data 형태로 가공   [{}]
					var chartData = [];
	        		for(i=0; i<result.length; i++) {
	        			var subarr = [result[i].DT, result[i].TEMP ];
	        			chartData.push(subarr);
	        		}
	        		if(result.length>0) {
	        			seq = result[result.length-1].SEQ
	        		}
	        		var where = data.getNumberOfRows();
	        		data.insertRows(where, chartData);
	        		chart.draw(data, options);
	        	}
	    	})
	 	}
	 	drawChart();
		setInterval(drawChart, 5000);
      }
    </script>
  </head>

  <body>
    <!--Div that will hold the pie chart-->
    <div id="chart_div"></div>
  </body>
</html>