# BFC(Busan Full Course)
***
## Introduction
<pre style="ine-height: 2">
2024-1 인터넷 DB 응용 프로젝트입니다.
추천하고 싶은 나만의 부산 여행지 또는 풀코스를
서로 공유하고 소통하는 웹사이트입니다.
</pre>
***
## Stack

<div align="center">
  <img src="https://img.shields.io/badge/html5-E34F26?style=for-the-badge&logo=html5&logoColor=white">
  <br>
  <img src="https://img.shields.io/badge/css-1572B6?style=for-the-badge&logo=css3&logoColor=white"> 
  <img src="https://img.shields.io/badge/Bootstrapap-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white"/>
  <br>
  <img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black"> 
  <img src="https://img.shields.io/badge/Java-007396.svg?&style=for-the-badge&logo=openjdk&logoColor=white"> 
  <img src="https://img.shields.io/badge/Jsp-e76f00?style=for-the-badge&logo=openjdk&logoColor=white">
  <br>
  <img src="https://img.shields.io/badge/ORACLE%20DATABASE-F80000?style=for-the-badge&logo=oracle&logoColor=white"/> 
  <img src="https://img.shields.io/badge/apachetomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black"> 
  <br>
  <img src="https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white"/> <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=GitHub&logoColor=white"/>
  <br>
  <img src="https://img.shields.io/badge/Eclipse%20IDE-2C2255.svg?&style=for-the-badge&logo=Eclipse%20IDE&logoColor=white"> 
  <img src="https://img.shields.io/badge/Discord-5865F2.svg?&style=for-the-badge&logo=Discord&logoColor=white"> 
</div>

***
## Git Flow
기본적으로 Git Flow 전략을 이용합니다. 작업 시작 시 선행되어야 할 작업은 다음과 같습니다.

```gradle
1. Issue를 생성한다.
2. feature Branch를 생성한다.
3. Add - Commit - Push - Pull Request 의 과정을 거친다.
4. merge된 작업이 있을 경우, 다른 브랜치에서 작업을 진행 중이던 개발자는 본인의 브랜치로 merge된 작업을 Pull 받아온다.
5. 종료된 Issue와 Pull Request의 Label과 Project를 관리한다.
```

## Branch Convention

```yaml
- [feature] : 기능 추가
- [fix] : 에러 수정, 버그 수정
- [docs] : README, 문서
- [refactor] : 코드 리펙토링 (기능 변경 없이 코드만 수정할 때)
- [modify] : 코드 수정 (기능의 변화가 있을 때)
- [chore] : 이외에 거의 모든 것
```

## Issue Template
```text
## 💥이슈 설명
***

## 📚할 일 목록
***

## 👀참고 사항
***

## ⌛기한
***

```

## Pr Template
```text
### ✨ 개요
<!-- 변경 사항 및 관련 이슈에 대해 간단하게 작성해주세요. 어떻게보다 무엇을 왜 수정했는지 설명해주세요. -->


### 🙋🏻 PR 타입(하나 이상의 PR 타입을 선택해주세요)
어떤 변경 사항이 있나요?

- [ ] 기능 추가 ✨
- [ ] 기능 삭제 🔥
- [ ] 버그 수정 🐛
- [ ] CSS 등 사용자 UI 디자인 변경 🎨
- [ ] 코드에 영향을 주지 않는 변경사항(오타 수정, 탭 사이즈 변경, 변수명 변경) ✏️
- [ ] 코드 형태 개선 🎨
- [ ] 주석 추가 및 수정 ✏️
- [ ] 문서 수정 📝
- [ ] 의존성, 환경 변수, 빌드 관련 코드 업데이트 🔨
- [ ] 파일 혹은 폴더명 수정 📂
- [ ] 파일 혹은 폴더 삭제 🗑️


### 📷 Key Changes
<!-- 구현 내용 중 애니메이션이나 화면 UI와 관련된 내용이 있을때 넣을 수 있다면 넣어주세요. -->


### ✍🏻 To Reviewers
<!-- 팀원들에게 코드리뷰를 할 때 확인해주었으면 하는 내용을 적어주세요. -->
<!-- 여기에서 이 부분 잘 모르겠는데 한번 봐주실 수 있나요? -->
```
