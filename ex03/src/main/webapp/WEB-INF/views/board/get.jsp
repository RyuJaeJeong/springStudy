<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>     
<%@include file="../includes/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Read</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">Board Read Page</div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                          		<div class="form-group">
                           			<label>bno</label> <input class="form-control" name="bno" value='${board.bno }' readonly="readonly">
                           		</div>
                           		<div class="form-group">

                           			<label>Title</label> <input class="form-control" name="title" value='<c:out value="${board.title }" />' readonly="readonly">
                           		</div>
                           		<div class="form-group">
                           			content :   <br>
                           			<label>Text area</label> 
                           			<textarea class="form-control" rows="3" name="content" readonly="readonly"><c:out value="${board.content }" /></textarea>
                           		</div>	
                           		<div class="form-group">
                           			<label>Writer</label> <input class="form-control" name="writer"  value='<c:out value="${board.writer }" />' readonly="readonly">
                           		</div>		
                           		<button data-oper='modify' class="btn btn-default"/>modify</button>
                           		<button data-oper='list' class="btn btn-info"/>List</button>
                           		<form id='operForm' action="/board/modify" method="get">
                           			<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno }" />'>
                           			<input type="hidden" name='pageNumber' value = '<c:out value="${cri.pageNumber}" />'>
                            		<input type="hidden" name='amount' value = '<c:out value="${cri.amount}" />'>
                            		<input type="hidden" name='type' value='<c:out value="${cri.type}" />' />
                            		<input type="hidden" name='keyword' value='<c:out value="${cri.keyword}" />' />
                           		</form>
                           
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
       <%@include file="../includes/footer.jsp" %>
       
<script type="text/javascript" src="/resources/js/reply.js"></script>       
<script>
$(document).ready(function(){
	console.log("JS TEST");
	console.log("====================")
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	
	//replyService add test
	/*replyService.add(
		{reply:"JS TEST", replyer:"tester", bno:bnoValue},		
		function(result) {
			alert("RESULT : " + result);
		}
	);
	
	replyService.getList({bno:bnoValue, page:1}, function(list){
		for(var i = 0, len = list.length||0; i < len; i++){
			console.log(list[i]);
		}	
	});
	
	replyService.remove(12, function(count){
		console.log( "count : " +  count);
		if(count === "success"){
			alert("REMOVED")
		}
	}, function(err) {
		alert('ERROR...');
	});
	
	replyService.update({
		rno : 2,
		bno : bnoValue,
		reply : "Modified Reply..."
	}, function(result){
		alert("수정완료...");		
	});*/
	
	replyService.get(11, function(data){
		console.log(data);
	});
	
	/*=============================*/
	var operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click", function(e){
		operForm.attr("action", "/board/modify").submit();
	});
	
	$("button[data-oper='list']").on("click", function(e){
		operForm.find("#bno").remove();
		operForm.attr("action", "/board/list").submit();
		operForm.submit();
	});
});

</script>       