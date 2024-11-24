<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="${board.getName() } 게시판" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<section class="mt-8">
	<div class="container mx-auto">
		<div class="w-9/12 mx-auto mb-2 pl-3 text-sm">
			<div>총 : ${articlesCnt }개</div>
		</div>
		<div class="w-9/12 mx-auto">
			<table class="table table-lg">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="article" items="${articles }">
						<tr class="hover">
							<td>${article.getId() }</td>
							<td class="link link-hover"><a href="detail?id=${article.getId() }">${article.getTitle() }</a></td>
							<td>${article.getLoginId() }</td>
							<td>${article.getRegDate().substring(2,16) }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		<c:if test="${rq.getLoginedMemberId() != -1 }">
			<div class="w-9/12 mx-auto flex justify-end my-3">
				<a class="btn btn-active btn-sm" href="write">글쓰기</a>
			</div>
		</c:if>
		
		<div class="mt-2 flex justify-center">
			<div class="join">
				<c:set var="path" value="?boardId=${board.getId() }" />
			
				<c:if test="${from != 1 }">
					<a class="join-item btn btn-sm" href="${path }&cPage=1"><i class="fa-solid fa-angles-left"></i></a>
					<a class="join-item btn btn-sm" href="${path }&cPage=${from - 1 }"><i class="fa-solid fa-angle-left"></i></a>
				</c:if>
				
				<c:forEach var="i" begin="${from }" end="${end }">
					<a class="join-item btn btn-sm ${cPage == i ? 'btn-active' : '' }" href="${path }&cPage=${i }">${i }</a>
				</c:forEach>
				
				<c:if test="${end != totalPagesCnt }">
					<a class="join-item btn btn-sm" href="${path }&cPage=${end + 1 }"><i class="fa-solid fa-angle-right"></i></a>
					<a class="join-item btn btn-sm" href="${path }&cPage=${totalPagesCnt }"><i class="fa-solid fa-angles-right"></i></a>
				</c:if>
			</div>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>