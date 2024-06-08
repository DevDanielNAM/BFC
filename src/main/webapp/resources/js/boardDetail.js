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
    const moreButtons = document.querySelectorAll(".reply-more-button");
    const moreButtonLists = document.querySelectorAll(".reply-view-more-button-lists");

    moreButtons.forEach((moreButton, index) => {
        const moreButtonList = document.getElementById(`reply-view-more-button-lists-${index}`);

        moreButton.onclick = (event) => {
            event.stopPropagation(); // 이벤트 전파를 막음
            if (moreButtonList.classList.contains("show")) {
                moreButtonList.classList.remove("show");
                setTimeout(() => {
                    moreButtonList.style.display = "none";
                }, 300); // transition 시간과 동일
            } else {
                moreButtonList.style.display = "block";
                setTimeout(() => {
                    moreButtonList.classList.add("show");
                }, 10); // 약간의 지연을 주어 display 변경 후 transition이 적용되도록 함
            }
        };
    });

    document.addEventListener("click", (event) => {
        moreButtonLists.forEach((moreButtonList, index) => {
            const moreButton = document.getElementById(`reply-more-button-${index}`);
            if (event.target !== moreButton && !moreButtonList.contains(event.target)) {
                if (moreButtonList.classList.contains("show")) {
                    moreButtonList.classList.remove("show");
                    setTimeout(() => {
                        moreButtonList.style.display = "none";
                    }, 300); // transition 시간과 동일
                }
            }
        });
    });
});



// Auto-resize textarea function
const textarea = document.getElementById("reply-write-area");
textarea.addEventListener("input", () => {
    this.style.height = "auto"; // Reset height to auto
    this.style.height = (this.scrollHeight) + "px"; // Set height to scrollHeight
});
