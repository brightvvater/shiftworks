<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<%@include file="index.jsp"%>
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="/resources/css/post.css">

<meta charset="UTF-8">
<title>일정 관리</title>
</head>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시판</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<button id='registerBtn' type="button" class="btn btn-primary ">
					새 게시물 등록</button>
			</div>

			<!-- /.panel-heading -->
			<div class="panel-body">
			
			<!--검색버튼 -->
				 <div class='row'>
					<div class="col-lg-12">
						<form id='searchForm' action="/board/list" method="get">
							<select name='type' class="form-select" aria-label="Default select example">
								<option value=""
									<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
								<option value="T"
									<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
								<option value="W"
									<c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
								<option value="TW"
									<c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>
									제목 or 작성자
								</option>
							</select> 
							<input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' />
							<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' /> 
							<button id='searchBtn' class='btn btn-primary'>검색 </button>
						</form>
					</div>
				</div>
			
			
			
				<!--메인 게시글-->
				<table id="boardTest" class="table table-striped table-bordered table-hover" border="1">
					<thead>
						<tr>
							<th>게시판번호</th>
							<th>게시글번호</th>
							<th>작성자</th>
							<th>작성부서</th>
							<th>제목</th>
							<th>작성일</th>
							<th>수정일</th>
						</tr>
					</thead>
					<tbody class="getPost">
						<c:forEach items="${pageMaker.list}" var="list">
							<tr>
								<td><c:out value="${list.b_id}" /></td>
								<td><a id ='<c:out value="${list.post_id}"/>' href ='<c:out value="${list.post_id}"/>'>
									<c:out value="${list.post_id}" /></a>
								</td>
								<td><c:out value="${list.name}" /></td>
								<td><c:out value="${list.dept_id}" /></td>
								<td><c:out value="${list.post_name}" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
									value="${list.post_regdate}" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
									value="${list.post_updatedate}" /></td>
							</tr>
						</c:forEach> 
					</tbody>
				</table>
				
				
				
				

				<!--페이지 처리 뷰-->
				<div class='pull-right'>
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li class="paginate_button previous">
							<a href="${pageMaker.startPage -1}">이전</a></li>
						</c:if>
						 <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
							<li class="paginate_button  ${pageMaker.cri.pageNum == num ? "active":""} ">
								<a href="${num}">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${pageMaker.next}">
							<li class="paginate_button next"><a href="${pageMaker.endPage +1 }">이후</a></li>
						</c:if>
					</ul>
				</div>
				<!--  end Pagination -->
			</div>
			<!-- end panelBody-->

			<form id='actionForm' action='/board/list' method='get'>
					<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
					<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
					<input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type}"/>'>
					<input type='hidden' name='keyword' value='<c:out value="${ pageMaker.cri.keyword}"/>'>
			</form> 
			
		
		
		<!-- Modal -->
      	<div class="modal" id="myModal">
        	<div class="modal-dialog">
          		<div class="modal-content">
            		<div class="modal-header">
              			<button type="button" class="close" data-dismiss="modal"></button>
              			<h4 class="modal-title" id="myModalLabel">알림</h4>
           		   </div>
            		<div class="modal-body">
                			<div>임시저장한 게시물이 있습니다.</div>
                			<div>이어서 작성하시겠습니까?</div>
            		</div>
					<div class="modal-footer">
        				<button id='modalModBtn' type="button" class="btn btn-primary">예</button>
        				<button id='modalRemoveBtn' type="button" class="btn btn-primary">아니오</button>
      				</div>         
      				
      			
       		</div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
      <!-- /.modal -->


		</div>
		<!--  end panel -->
	</div>
	<!-- end class -->
</div>
<!-- /.row -->

<script type="text/javascript" src="/resources/js/post.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	

	var searchForm = $("#searchForm");
	var formType = searchForm.find("select[name='type']");
	var formKeyword = searchForm.find("input[name='keyword']");
	var formPageNum = searchForm.find("input[name='pageNum']");
	


	 //새 게시물 등록 선택 시 register.jsp 이동
	  $("#registerBtn").on("click",function(e){
		  
		  
		//onload 됐을 때 emp_id값과 b_id에 맞는 temp_board데이터가 있으면 불러오기
		postService.temporalSelect(function(result){
			if(result){
				 $(".modal").show();
				 $("#modalRemoveBtn").on("click",function(){
					 $(".modal").hide();
					 location.href = "/board/new";
				 })
				 $("#modalModBtn").on("click",function(){
					 $(".modal").hide();
					 location.href ="/board/temporalview";
				 })
				 
			}
			else{
				location.href = "/board/new";
			}
		})
		
	     
	      
	  });//end register
	 
	 
	 //pagination
	  $(".paginate_button a").on("click", function(e) {
					e.preventDefault();
					
					console.log('click');
					$("#actionForm").find("input[name='pageNum']").val($(this).attr("href"));
					$("#actionForm").submit();
	   });
		
	  
	  
	 //검색 버튼 클릭 시 검색한 list 불러오기
	 var searchForm = $("#searchForm");
	  
	  $("#searchBtn").on("click", function(e){
		  
		  if (!searchForm.find("option:selected").val()) {
				alert("검색종류를 선택하세요");
				return false;
			}
			if (!searchForm.find("input[name='keyword']").val()) {
				alert("키워드를 입력하세요");
				return false;
			}
			searchForm.find("input[name='pageNum']").val("1");
			searchForm.submit();
	  });
		
	  
	  
	  //글번호 클릭 시 get.jsp 이동하기
	  $(".getPost").on("click",function(e){
		  	
			e.preventDefault();
			var post_id = $(this).attr("href");
			console.log(post_id);

			//history 테이블에 넣어서 읽음 표시하기
			postService.insertHistory({post_id:post_id});
			
			//get.jsp이동
			  $("#actionForm") .
				append("<input type='hidden' name='post_id' value='"+ $(this).attr("href")+ "'>");
			
			$("#actionForm").attr("action","/board/get");
			$("#actionForm").submit();  
		
	  });
	  
	 
	  
	 //안읽은 게시물 bold처리추가하기
	  postService.getHistory(function(result){
		  
		 	 var list = [];
			<c:forEach items="${pageMaker.list}" var="post">
				list.push("${post.post_id}");
			</c:forEach>
			
		
			console.log(result[0].post_id);
			var arr= [];
			for(var i=0;i<result.length;i++){
				arr.push(result[i].post_id+"");
			}
			
			console.log(list);
			console.log(arr);
			var x = list.filter(x=> !arr.includes(x));
			console.log(x); //안읽은 게시물의 게시물 번호
			 
			
			x.forEach(u => {
				$('#' + u).parent().parent().addClass("getBold");
			})
	  })
	
	    	
	  
});
</script>


