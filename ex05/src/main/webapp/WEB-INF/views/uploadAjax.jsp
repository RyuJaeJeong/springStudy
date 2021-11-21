<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.uploadResult {
	width:100%;
	background-color: gray;
}

.uploadResult ul {
	disply:flex;
	flex-flow:row;
	justify-content: center;
	align-items: center;
}
.uploadResult ul li{
	list-style: none;
	padding:10px;
}

.uploadResult ul li img{
	width: 20px;
}

.bigPictureWrapper{
	position: absolute;
	display : none;
	justify-content : center;
	align-items: center;
	top:0%;
	width:100%;
	height:100%;
	background-color: gray;
	z-index:100%;
	background: rgba(255,255,255,0,5);
}

.bigPicture{
	position:relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width:600px;
}

</style>

</head>
<body>
	<div class="uploadDiv">
		<input type='file' name='uploadFile' multiple>
		
	</div>
	
	<div class="uploadResult">
		<ul>
		
		</ul>
	</div>
	
	<div class='bigPictureWrapper'>
		<div class='bigPicture'>
		
		</div>
	</div>
	
	<button onclick="upload()">submit</button>
	
<script
  src="https://code.jquery.com/jquery-3.6.0.min.js"
  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  crossorigin="anonymous"></script>
<script>

$(".bigPictureWrapper").on("click", function(e){
	$(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
	setTimeout(function(){
		$('.bigPictureWrapper').hide();
	}, 1000);
});

$(".uploadResult").on("click", "span", function(e){
	var targetFile = $(this).data("file");
	var type = $(this).data("type");
	console.log("target : " + targetFile);
	
	$.ajax({
		url: '/deleteFile',
		data: {fileName: targetFile, type:type},
		dataType: 'text',
		type: 'POST',
		success: function(result) {
			alert(result);	
		}
	});	//end ajax
	
});

//사진 원본 클릭시 축소

	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880;
	var uploadResult = $(".uploadResult ul");
	
	function upload() {
		//가상의 form 태그 FormData 객체
		var formData = new FormData();
		
		var inputFile = $("input[name='uploadFile']");
		
		var files = inputFile[0].files;
		console.log(files);
		
		
		
		for (var i = 0; i < files.length; i++) {
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url: '/uploadAjaxAction',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			success: function(result) {
				console.log(result);
				//업로드 후 div 초기화 시켜줌
				showUploadFile(result);
				$(".uploadDiv").html(cloneObj.html())
			}
		});	//end ajax
		
	}//end upload
	
	function checkExtension(fileName, fileSize){
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드 할 수 없습니다.");
			return false;
		}
		
		return true;
	}//end checkExtension
	
	//빈 업로드 객체를 복사해둠 
	var cloneObj = $(".uploadDiv").clone();
	
	
	
	//원본 사진 보이기
	function showImage(fileCallPath){
		$(".bigPictureWrapper").css("display", "flex").show();
		$(".bigPicture")
		.html("<img src = '/display?fileName="+ encodeURI(fileCallPath) + "'>")
		.animate({width:'100%', height: '100%'}, 1000);
	}
	
	//업로드 파일을 화면에 뿌려주기 위한 함수
	function showUploadFile(uploadResultArr) {
		var str = "";
		
		$(uploadResultArr).each(function(i, obj){
			
			if(!obj.image){
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
				alert(fileCallPath);
				str += "<li><div><img src='/resources/image/attach.png'>" + obj.fileName + "</li>"
				str += "<span data-file=\'"+fileCallPath+"\' data-type='file'>x </span>"
				str += "</div></li>"
			}else{
				//str += "<li>" + obj.fileName + "</li>";
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				alert(fileCallPath);
				var originPath = obj.uploadPath+"\\"+obj.uuid+"_"+obj.fileName;
				originPath = originPath.replace(new RegExp(/\\/g), "/");
				
				str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\"><img src='/display?fileName="+fileCallPath+"'>"+obj.fileName+"</a></li>";
				str += "<span data-file=\'"+fileCallPath+"\' data-type='image'>x</span>"
			}
		});
		uploadResult.append(str);
	}//end showUploadFile 
	
	
	
</script>  
</body>
</html>

