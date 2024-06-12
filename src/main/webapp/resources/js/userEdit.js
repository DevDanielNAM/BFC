/**
 * 
 */
 const callConfirm = (type) => {
	 if (confirm(`${type}하시겠습니까?`)) {
		window.location.href = "userInformation.jsp?type=" + encodeURIComponent(type);
	 }
};