// confirm to edit or delete
const callConfirm = (type, postId) => {
	if(confirm(`${type}하시겠습니까?`)){
		window.location.href = "boardEditDeleteRedirect.jsp?type=" + encodeURIComponent(type) + "&postId=" + encodeURIComponent(postId);
	} else {
		alert(`${type}하기가 취소되었습니다`);
	}
};


// reply login alert
const showLoginAlert = () => {
	if(confirm(`로그인을 하시겠습니까?`)){
		window.location.href = "../member/login.jsp";
	} else {
		alert(`로그인하기를 취소하셨습니다`);
	}
}

const disabledReplyBox = document.getElementById("disable-reply-box");
try {
	disabledReplyBox.onclick = (event) => {
		showLoginAlert();
	};	
} catch(e) {}


// confirm reply submission
const confirmSubmission = () => {
    const confirmed = confirm("댓글을 추가하시겠습니까?");
    if (!confirmed) {
        alert("댓글 추가가 취소되었습니다");
    }
    return confirmed;
}


// Show course details when the course image is clicked
const showCourseDetail = (element) => {
	// 클릭된 코스 이미지의 배경과 숫자를 선택
    document.querySelectorAll('.course-image-wrap').forEach(li => li.classList.remove('active-course-image'));
    document.querySelectorAll('.course-number').forEach(li => li.classList.remove('active-course-number'));

    element.querySelector('.course-image-wrap').classList.add('active-course-image');
    element.querySelector('.course-number').classList.add('active-course-number');
    
    // 클릭된 코스 숫자의 진행도 나타내는 선
    const allLiElements = document.querySelectorAll('.course-lists .course-list');
        
    allLiElements.forEach(li => {
        li.classList.remove('course-on-half', 'course-on-full');
    });

    const index = Array.from(allLiElements).indexOf(element);

    element.classList.add('course-on-half');

    for (let i = 0; i < index; i++) {
        allLiElements[i].classList.add('course-on-full');
    }
    
    // 선택된 코스의 상세 정보를 나타내줌
    const courseDetailTitle = document.getElementById("course-detail-title");
    const courseDetailLocation = document.getElementById("course-detail-location");
    const courseDetailImage = document.getElementById("course-detail-image");
    const courseDetailContent = document.getElementById("course-detail-content");
    const courseDetailTags = document.getElementById("course-detail-tags");
    
    const courseInfo = element.querySelector('.course-info');

    const title = courseInfo.getAttribute('data-title');
    const location = courseInfo.getAttribute('data-location');
    const image = courseInfo.getAttribute('data-image');
    const content = courseInfo.getAttribute('data-content');
    const contentId = courseInfo.getAttribute('data-content-id');
    
    courseDetailTitle.innerHTML = title;
    courseDetailLocation.innerHTML = location;
    courseDetailImage.src  = image;
    courseDetailContent.innerHTML = content;
    
     fetch(`getHashtags.jsp?contentId=${contentId}`)
        .then(response => response.json())
        .then(hashtags => {
            courseDetailTags.innerHTML = '';

            // Add new tags
            hashtags.forEach(tag => {
                const li = document.createElement('li');
                li.textContent = `#${tag}`;
                courseDetailTags.appendChild(li);
            });
        })
        .catch(error => console.error('Error fetching hashtags:', error));
}


// reply more button 클릭 시 수정, 삭제 toggle
document.addEventListener("DOMContentLoaded", () => {
    const moreButtons = document.querySelectorAll(".reply-more-button");
    const moreButtonLists = document.querySelectorAll(".reply-view-more-button-lists");
	const editButtons = document.querySelectorAll(".edit-reply");
    const cancelButtons = document.querySelectorAll(".cancel-edit");
    const textareas = document.querySelectorAll(".edit-reply-form > textarea");

    function autoResizeTextarea(textarea) {
        textarea.style.height = 'auto'; // 먼저 높이를 자동으로 설정하여 스크롤을 없앰
        textarea.style.height = (textarea.scrollHeight || 57) + 'px'; // 내용의 높이에 맞게 조절
    }
    
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
    
    editButtons.forEach((editButton, index) => {
        editButton.onclick = (event) => {
            event.preventDefault();
            const content = editButton.getAttribute("data-content");
            const editForm = document.getElementById(`edit-reply-form-${index}`);
            const textarea = editForm.querySelector('textarea');
            textarea.value = content;
            autoResizeTextarea(textarea); // 수정할 때 초기 높이를 조정
            document.getElementById(`reply-content-${index}`).style.display = 'none';
            editForm.style.display = 'flex';
        };
    });

    cancelButtons.forEach((cancelButton, index) => {
        cancelButton.onclick = (event) => {
            const editForm = document.getElementById(`edit-reply-form-${index}`);
            const originalContent = document.querySelector(`.edit-reply[data-index="${index}"]`).getAttribute("data-content");
            const textarea = editForm.querySelector('textarea');
            textarea.value = originalContent;
            autoResizeTextarea(textarea); // 취소할 때 높이를 조정
            editForm.style.display = 'none';
            document.getElementById(`reply-content-${index}`).style.display = 'block';
        };
    });
    
    // textarea의 내용이 변경될 때마다 높이를 자동으로 조절
    textareas.forEach(textarea => {
        textarea.addEventListener('input', () => autoResizeTextarea(textarea));
        autoResizeTextarea(textarea); // 초기 로드 시 높이를 조정
    });
});


// Auto-resize textarea
const textarea = document.getElementById("reply-write-area");
try{
	textarea.addEventListener("input", () => {
	    textarea.style.height = "auto"; // Reset height to auto
	    textarea.style.height = (textarea.scrollHeight) + "px"; // Set height to scrollHeight
	});	
} catch(e) {
	console.log("please login and then show textarea!");
}


// Carousel Slide
document.addEventListener("DOMContentLoaded", () => {
      const content = document.querySelector(".content");
      const courseLists = document.querySelector(".course-lists");
      const slides = document.querySelectorAll(".course-lists li");
      const prevButton = document.querySelector(".prev-button");
      const nextButton = document.querySelector(".next-button");
      const LIST_WIDTH = 210;
      const LIST_MARGIN = 15;
      const totalSlides = slides.length;
      let contentWidth = content.offsetWidth;
      let currentIndex = 0;
      let maxIndex = 1;

	  
      function updateSlidePosition() {
        const newTransformValue = -currentIndex * Math.floor((contentWidth / LIST_WIDTH)) * LIST_WIDTH + "px";
        courseLists.style.transform = `translateX(${newTransformValue})`;
      }

      function checkButtonVisibility() {
		try {
	        if (contentWidth - totalSlides * LIST_WIDTH >= 0) {
	          prevButton.style.display = 'none';
	          nextButton.style.display = 'none';
	        } else {
	          prevButton.style.display = 'block';
	          nextButton.style.display = 'block';
	        }			
		} catch(e) {
			  prevButton.style.display = 'none';
		      nextButton.style.display = 'none';
		}
      }
      
      function updateMaxIndex() {
        contentWidth = content.offsetWidth;
        if ((totalSlides * LIST_WIDTH - contentWidth) < LIST_MARGIN) { 
          maxIndex = 0;
        } else if ((totalSlides * LIST_WIDTH - contentWidth) < (LIST_WIDTH + LIST_MARGIN)) { 
          maxIndex = 1;
        } else if(Math.floor((contentWidth / LIST_WIDTH)) === 1) {
			maxIndex = totalSlides - 1;
		} else {
			maxIndex = Math.round(totalSlides / Math.floor((contentWidth / LIST_WIDTH))) - 1;
		}
        updateButtonStates();
      }

      function updateButtonStates() {
        if (currentIndex === 0) {
          prevButton.classList.add('disabled');
        } else {
          prevButton.classList.remove('disabled');
        }

        if (currentIndex >= maxIndex) {
          nextButton.classList.add('disabled');
        } else {
          nextButton.classList.remove('disabled');
        }
      }
      updateButtonStates();

      prevButton.addEventListener("click", () => {
        if (currentIndex > 0) {
          currentIndex--;
          updateSlidePosition();
          updateButtonStates();
        }
      });

      nextButton.addEventListener("click", () => {
        if (currentIndex < maxIndex) {
          currentIndex++;
          updateSlidePosition();
          updateButtonStates();
        }
      });

      window.addEventListener("resize", () => {
		checkButtonVisibility();
		updateMaxIndex();
		currentIndex = 0;
		courseLists.style.transform = `translateX(0)`;
	  });
      checkButtonVisibility();
      updateMaxIndex();
});

