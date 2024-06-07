const callConfirm = (type) => {
	if(confirm(`${type}하시겠습니까?`)){
		window.location.href = "boardEditDeleteRedirect.jsp?type=" + encodeURIComponent(type);
	} else {
		alert(`${type}하기가 취소되었습니다`);
	}
};

const confirmSubmission = () => {
    const confirmed = confirm("댓글을 추가하시겠습니까?");
    if (!confirmed) {
        alert("댓글 추가가 취소되었습니다");
    }
    return confirmed;
}