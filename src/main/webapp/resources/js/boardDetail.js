const callConfirm = (type) => {
	if(confirm(`${type}하시겠습니까?`)){
		window.location.href = "boardEditDeleteRedirect.jsp?type=" + encodeURIComponent(type);
	} else {
		alert(`${type}하기가 취소되었습니다`);
	}
};



// confirm reply submission
const confirmSubmission = () => {
    const confirmed = confirm("댓글을 추가하시겠습니까?");
    if (!confirmed) {
        alert("댓글 추가가 취소되었습니다");
    }
    return confirmed;
}



// reply more button 클릭 시 수정, 삭제 toggle
document.addEventListener("DOMContentLoaded", () => {
    const moreButton = document.getElementById("reply-more-button");
    const moreButtonLists = document.getElementById("reply-view-more-button-lists");

    moreButton.onclick = (event) => {
        event.stopPropagation(); // 이벤트 전파를 막음
        if (moreButtonLists.classList.contains("show")) {
            moreButtonLists.classList.remove("show");
            setTimeout(() => {
                moreButtonLists.style.display = "none";
            }, 300); // transition 시간과 동일
        } else {
            moreButtonLists.style.display = "block";
            setTimeout(() => {
                moreButtonLists.classList.add("show");
            }, 10); // 약간의 지연을 주어 display 변경 후 transition이 적용되도록 함
        }
    };

    document.addEventListener("click", (event) => {
        if (event.target !== moreButton && !moreButtonLists.contains(event.target)) {
            if (moreButtonLists.classList.contains("show")) {
                moreButtonLists.classList.remove("show");
                setTimeout(() => {
                    moreButtonLists.style.display = "none";
                }, 300); // transition 시간과 동일
            }
        }
    });
});



// Auto-resize textarea function
const textarea = document.getElementById("reply-write-area");
textarea.addEventListener("input", () => {
    this.style.height = "auto"; // Reset height to auto
    this.style.height = (this.scrollHeight) + "px"; // Set height to scrollHeight
});
