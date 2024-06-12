let fieldCount = 1;
function addFields() {

	var inputFields = document.getElementById("inputFields");

	// Create new file input group
	var newFileDiv = document.createElement("div");
	newFileDiv.className = "form-group";

	var newFileLabel = document.createElement("label");
	newFileLabel.innerHTML = "파일 업로드:";

	var newFileInput = document.createElement("input");
	newFileInput.type = "file";
	newFileInput.name = "file" + fieldCount;
	newFileInput.required = false;

	newFileDiv.appendChild(newFileLabel);
	newFileDiv.appendChild(newFileInput);

	// Create new content input group
	var newContentDiv = document.createElement("div");
	newContentDiv.className = "form-group";

	var newContentLabel = document.createElement("label");
	newContentLabel.innerHTML = "내용:";

	var newTextArea = document.createElement("textarea");
	newTextArea.name = "content" + fieldCount;
	newTextArea.rows = 15;
	newTextArea.cols = 40;
	newTextArea.style.resize = "none";
	newTextArea.required = true;

	newContentDiv.appendChild(newContentLabel);
	newContentDiv.appendChild(newTextArea);

	// Append new fields to the inputFields div
	inputFields.appendChild(newFileDiv);

	inputFields.appendChild(newContentDiv);
	document.getElementById("fc").value = fieldCount;
	fieldCount++;
}