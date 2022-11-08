<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@include file="/WEB-INF/views/includes/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="/resources/css/post.css">

<meta charset="UTF-8">
<title></title>
</head>

<div class="container">
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">결재문서함 상세페이지</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
    

<!--게시글 상세 폼-->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
		

			<!-- /.panel-heading -->
			<div class="panel-body">
			
				<div class="form-group">
					<label>결재문서번호</label> 
					<input class="form-control" name='scrap_id'
						value='<c:out value="${post.apr_id }"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>문서양식</label> 
						<input class="form-control" name='name' 
							value='<c:out value="${post.af_id }"/>'   readonly="readonly">
				</div>
				<div class="form-group">
					<label>작성자</label> 
					<input class="form-control" name='name'
						value='<c:out value="${post.name }"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>결재제목</label> <input class="form-control" name='dept_id'
						value='<c:out value="${post.apr_title }"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>결재내용</label>
					<textarea class="form-control" rows="20" cols="150" name='post_content'
						readonly="readonly"><c:out value="${post.apr_content}" /></textarea>
				</div>
				<div class="form-group">
					<label>결재상태</label> 
						<input class="form-control" name='name' 
							value='<c:out value="${post.apr_status }"/>'   readonly="readonly">
				</div>
				<div class="form-group">
					<label>결재일자</label> 
					<input class="form-control" name='scrap_date'
						value='<c:out value="${post.apr_signdate}"/>' readonly="readonly">
				</div>
				<button id='listBtn' class='btn btn-primary btn-xs pull-right'>목록</button>
<!-- 게시글 상세 폼-->
			</div>
			<!--  end panel-body -->

		</div>
		<!--  end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- /.row -->
</div>



<script type="text/javascript" src="/resources/js/post.js"></script>
<script>
		
//list버튼 클릭 시 목록이동 추후 페이지까지 들고 가야 함
$('#listBtn').on("click", function(e) {

	location.href = "/document/myApproval/1";

});


</script>
</html>