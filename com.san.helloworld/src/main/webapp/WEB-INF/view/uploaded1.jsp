<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.ui.widget.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.iframe-transport.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.fileupload.js"></script>
</head>
<body>
<!-- 	<h1 id='banner'>Upload Files</h1> -->
	
	<div>
		<form id='uploadForm'>
  			<fieldset>
				<legend>Files</legend>
				<label for='owner'>Owner:</label><input type='text' id='owner'/><br/>
				<textarea name="description" id="description">Description here</textarea><br/>
				<span id='filename'></span><br/>
				<a href='#' id='attach'>Add a file</a><br/>
				<input id="upload" type="file" name="file" data-url="file" multiple style="opacity: 0; filter:alpha(opacity: 0);"><br/>
				<input type='button' value='Reset' id='reset' />
				<input type='submit' value='Upload' id='submit'/>
  			</fieldset>
		</form>
	</div>
	
	<div id='msgbox' title='' style='display:none'></div>
</body>
</html>

<script type='text/javascript'>
	$(function() {
		init();
	});
	
	function init() {
// 		$('input:button').button();
// 		$('#submit').button();
		
		$('#uploadForm').submit(function(event) {
			event.preventDefault();	
			
			$.postJSON('file', {
						owner: $('#owner').val(),
						description: $('#description').val(),
						filename: getFilelist()
					},
					function(result) {
						if (result.success == true) {
							dialog('Success', 'Files have been uploaded!');
						} else {
							dialog('Failure', 'Unable to upload files!');
						}
			});
		});
		
		$('#reset').click(function() {
			clearForm();
			dialog('Success', 'Fields have been cleared!');
		});
		
		$('#upload').fileupload({
	        dataType: 'json',
	        done: function (e, data) {
	            $.each(data.result, function (index, file) {
	                $('body').data('filelist').push(file);
	                $('#filename').append(formatFileDisplay(file));
	                $('#attach').empty().append('Add another file');
	            });
	        }
	    });
		
		// Technique borrowed from http://stackoverflow.com/questions/1944267/how-to-change-the-button-text-of-input-type-file
		// http://stackoverflow.com/questions/210643/in-javascript-can-i-make-a-click-event-fire-programmatically-for-a-file-input
		$("#attach").click(function () {
		    $("#upload").trigger('click');
		});
		
		$('body').data('filelist', new Array());
	}
	
	function formatFileDisplay(file) {
		var size = '<span style="font-style:italic">'+(file.size/1000).toFixed(2)+'K</span>';
		return file.name + ' ('+ size +')<br/>';
	}
	
	function getFilelist() {
		var files = $('body').data('filelist');
		var filenames = '';
		for (var i=0; i<files.length; i<i++) {
			var suffix = (i==files.length-1) ? '' : ',';
			filenames += files[i].name + suffix;
		}
		return filenames;
	}
	
	function dialog(title, text) {
		$('#msgbox').text(text);
		$('#msgbox').dialog( 
				{	title: title,
					modal: true,
					buttons: {"Ok": function()  {
						$(this).dialog("close");} 
					}
				});
	}
	
	function clearForm() {
		$('#owner').val('');
		$('#description').val('');
		$('#filename').empty();
		$('#attach').empty().append('Add a file');
		$('body').data('filelist', new Array());
	}
	</script>