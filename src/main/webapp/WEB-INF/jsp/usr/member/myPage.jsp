<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="회원 정보" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<section class="mt-8">
	<div class="container mx-auto">
		<div class="w-9/12 mx-auto">
			<table class="table table-lg">
				<tr>
					<th>가입일</th>
					<td>${member.getRegDate().substring(0, 16) }</td>
				</tr>
				<tr>
					<th>정보 수정일</th>
					<td>${member.getUpdateDate().substring(0, 16) }</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td>${member.getLoginId() }</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>${member.getName() }</td>
				</tr>
			</table>
		</div>
		
		<div class="w-9/12 mx-auto mt-3 text-sm flex justify-between">
			<div>	
				<button class="btn btn-active btn-sm" onclick="history.back();">뒤로가기</button>
			</div>
			<div>
				<a class="btn btn-active btn-sm" href="checkPw">회원정보수정</a>
			</div>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>