

 function createReport(form){
        changeControlValue(form.resulthandler,"/html/nds/reports/report_generator.jsp");
        submitForm(form);
    }
	function previewReport(reportURL){
    	popup_window(reportURL);
	}
    function editReport(reportId){
    	url="/html/nds/object/object.jsp?table=ad_report&id="+reportId;
    	popup_window(url);
    }
    function editJReport(reportId){
    	url="/html/nds/object/object.jsp?table=ad_cxtab&id="+reportId;
    	popup_window(url);
    }
    function checkActionPath(){

    }
    
    function confirmFileName(){
    	var d=new Date();
    	var destFile="rpt"+ d.getDate()+"_"+ d.getHours()+ d.getMinutes();
		var theResponse = window.prompt(gMessageHolder.INPUT_FILE_NAME,destFile);
		if(theResponse!=null && theResponse.length>0){
			form1.destfile.value=theResponse;
			return true;
		}
		return false;
    }
	function exportPDF(reportId){
    	form1.reportid.value=reportId;
    	form1.filetype.value='pdf';
    	
    	form1.resulthandler.value="/html/nds/print/save_pdf.jsp";
    	if(!confirmFileName()) return;
    	checkActionPath();
    	submitForm(form1);
    }
    function exportExcel(reportId){
    	form1.reportid.value=reportId;
    	form1.filetype.value='xls';
    	
    	form1.resulthandler.value="/html/nds/print/save_excel.jsp";
    	checkActionPath();
    	if(!confirmFileName()) return;
    	submitForm(form1);
    }
    function exportCSV(reportId){
    	form1.reportid.value=reportId;
    	form1.filetype.value='csv';
    	
    	form1.resulthandler.value="/html/nds/print/save_csv.jsp";
    	checkActionPath();
    	if(!confirmFileName()) return;
    	submitForm(form1);
    }
       
    function displayPDF(reportId){
		form1.reportid.value=reportId;
    	form1.filetype.value='pdf';
    	form1.resulthandler.value="/servlets/binserv/ViewPDF";
    	checkActionPath();
    	submitForm(form1);		    
    }
    function displayHTML(reportId){
		form1.reportid.value=reportId;
    	form1.filetype.value='html';
    	form1.resulthandler.value="/servlets/binserv/ViewHTML";
    	checkActionPath();
    	submitForm(form1);		    
    }
	function exportJPDF(reportId){
    	form1.isjreport.value='Y';
    	exportPDF(reportId);
    }
    function exportJExcel(reportId){
    	form1.isjreport.value='Y';
    	exportExcel(reportId);
    }
    function exportJCSV(reportId){
    	form1.isjreport.value='Y';
    	exportCSV(reportId);
    }

    function displayJPDF(reportId){
		form1.isjreport.value='Y';
    	displayPDF(reportId);
    }
    function displayJHTML(reportId){
		form1.isjreport.value='Y';
		displayHTML(reportId);
    }    
    function checkTemplate(tid){
    	showDialog("/html/nds/print/check_template.jsp?table="+tid, 400, 200,true);
    }