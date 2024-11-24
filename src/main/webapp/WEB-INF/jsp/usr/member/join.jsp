<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="회원가입" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<script>
	let validLoginId = null;

	const joinForm_onSubmit = function(form) {
		form.loginId.value = form.loginId.value.trim();
		form.loginPw.value = form.loginPw.value.trim();
		form.pwChk.value = form.pwChk.value.trim();
		form.name.value = form.name.value.trim();
		
		if (form.loginId.value.length == 0) {
			alert('아이디를 입력해주세요');
			form.loginId.focus();
			return;
		}
		
		if (form.loginId.value != validLoginId) {
			alert('[ ' + form.loginId.value + ' ] 은(는) 사용할 수 없는 아이디입니다');
			form.loginId.value = '';
			form.loginId.focus();
			return;
		}
		
		if (form.loginPw.value.length == 0) {
			alert('비밀번호를 입력해주세요');
			form.loginPw.focus();
			return;
		}
		
		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요');
			form.name.focus();
			return;
		}
		
		if (form.loginPw.value != form.pwChk.value) {
			alert('비밀번호가 일치하지 않습니다');
			form.loginPw.value = '';
			form.pwChk.value = '';
			form.loginPw.focus();
			return;
		}
		
		form.submit();
	}
	
	const loginIdDupChk = function(el) {
		el.value = el.value.trim();
		
		let loginIdDupChkMsg = $('#loginIdDupChkMsg');
		
		if (el.value.length == 0) {
			loginIdDupChkMsg.removeClass('text-green-500');
			loginIdDupChkMsg.addClass('text-red-500');
			loginIdDupChkMsg.html(`<span>아이디는 필수 입력 정보입니다</span>`);
			return;
		}
		
		$.ajax({
			url : '/usr/member/loginIdDupChk',
			type : 'GET',
			data : {
				loginId : el.value
			},
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					loginIdDupChkMsg.removeClass('text-red-500');
					loginIdDupChkMsg.addClass('text-green-500');
					loginIdDupChkMsg.html(`<span>\${data.resultMsg }</span>`);
					validLoginId = el.value;
				} else {
					loginIdDupChkMsg.removeClass('text-green-500');
					loginIdDupChkMsg.addClass('text-red-500');
					loginIdDupChkMsg.html(`<span>\${data.resultMsg }</span>`);
					validLoginId = null;
				}
			},
			error : function(xhr, status, error) {
				console.log(error);
			}
		})
	}
</script>

<section class="mt-8">
	<div class="container mx-auto">
		<form action="doJoin" method="post" onsubmit="joinForm_onSubmit(this); return false;">
			<div class="w-9/12 mx-auto">
				<table class="table table-lg">
					<tr height="110">
						<th>아이디</th>
						<td>
							<input class="input input-bordered w-full max-w-xs" type="text" name="loginId" placeholder="아이디를 입력해주세요" onblur="loginIdDupChk(this);"/>
							<div id="loginIdDupChkMsg" class="mt-2 text-sm h-5 w-96"></div>
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input class="input input-bordered w-full max-w-xs" type="text" name="loginPw" placeholder="비밀번호를 입력해주세요" /></td>
					</tr>
					<tr>
						<th>비밀번호 확인</th>
						<td><input class="input input-bordered w-full max-w-xs" type="text" name="pwChk" placeholder="비밀번호 확인을 입력해주세요" /></td>
					</tr>
					<tr>
						<th>이름</th>
						<td><input class="input input-bordered w-full max-w-xs" type="text" name="name" placeholder="이름을 입력해주세요" /></td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="flex justify-center">
								<button class="btn btn-active btn-wide">가입</button>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</form>
		<div class="w-9/12 mx-auto mt-3 text-sm flex justify-between">
			<div>	
				<button class="btn btn-active btn-sm" onclick="history.back();">뒤로가기</button>
			</div>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>