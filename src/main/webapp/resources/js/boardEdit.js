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
    newFileInput.id = "file" + fieldCount;
    newFileInput.required = false;

    newFileDiv.appendChild(newFileLabel);
    newFileDiv.appendChild(newFileInput);
    
    // Create new title input group
    var newTitleDiv = document.createElement("div");
    newTitleDiv.className = "form-group";

    var newTitleLabel = document.createElement("label");
    newTitleLabel.innerHTML = "코스 제목:";

    var newTitleInput = document.createElement("input");
    newTitleInput.type = "text";
    newTitleInput.name = "title" + fieldCount;
    newTitleInput.id = "title" + fieldCount;
    newTitleInput.size = 1;
    newTitleInput.required = true;

    newTitleDiv.appendChild(newTitleLabel);
    newTitleDiv.appendChild(newTitleInput);

    inputFields.appendChild(newTitleDiv);

    // Create new location input group
    var newLocationDiv = document.createElement("div");
    newLocationDiv.className = "form-group";

    var newLocationLabel = document.createElement("label");
    newLocationLabel.innerHTML = "코스 위치:";

    var newLocationInput = document.createElement("input");
    newLocationInput.type = "text";
    newLocationInput.name = "location" + fieldCount;
    newLocationInput.id = "location" + fieldCount;
    newLocationInput.size = 1;
    newLocationInput.required = true;

    newLocationDiv.appendChild(newLocationLabel);
    newLocationDiv.appendChild(newLocationInput);

    inputFields.appendChild(newLocationDiv);

    // Create new content input group
    var newContentDiv = document.createElement("div");
    newContentDiv.className = "form-group";

    var newContentLabel = document.createElement("label");
    newContentLabel.innerHTML = "코스 소개:";

    var newTextArea = document.createElement("textarea");
    newTextArea.name = "content" + fieldCount;
    newTextArea.id = "content" + fieldCount;
    newTextArea.rows = 15;
    newTextArea.cols = 40;
    newTextArea.style.resize = "none";
    newTextArea.required = true;

    newContentDiv.appendChild(newContentLabel);
    newContentDiv.appendChild(newTextArea);

    // Append new fields to the inputFields div
    inputFields.appendChild(newFileDiv);
    inputFields.appendChild(newContentDiv);


    // Create new tag input group
    var newTagDiv = document.createElement("div");
    newTagDiv.className = "form-group";

    var newTagLabel = document.createElement("label");
    newTagLabel.innerHTML = "태그:";

    var newTagInput = document.createElement("input");
    newTagInput.type = "text";
    newTagInput.name = "tag" + fieldCount;
    newTagInput.id = "tag" + fieldCount;
    newTagInput.size = 1;
    newTagInput.placeholder = "각 태그들은 띄어쓰기로 구분됩니다.";
    newTagInput.required = true;

    newTagDiv.appendChild(newTagLabel);
    newTagDiv.appendChild(newTagInput);

    inputFields.appendChild(newTagDiv);

    document.getElementById("fc").value = fieldCount;
    fieldCount++;
}