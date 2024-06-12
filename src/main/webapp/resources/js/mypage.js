const callConfirm = (type) => {
	if(type === '수정'){
		window.location.href = "userInformation.jsp?type=" + encodeURIComponent(type);
	}
	else{
		if (confirm(`${type}하시겠습니까?`)) {
			if (type === '탈퇴') {
				if (confirm(`진짜로 탈퇴하시겠습니까?`)) {
					window.location.href = "userInformation.jsp?type=" + encodeURIComponent(type);
				}
			}
			else {
				window.location.href = "userInformation.jsp?type=" + encodeURIComponent(type);
			}
		}
	}
};

const moveBoardDetail = (postId) => {
	window.location.href = "../board/boardDetail.jsp?type=" + encodeURIComponent(postId);
};