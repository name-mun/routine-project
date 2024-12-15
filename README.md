# Routine-Project
![루틴 화면](https://github.com/user-attachments/assets/faa19f69-0aab-45c8-91fd-48c433639b26)

## 목차
1. [프로젝트 소개](#star-프로젝트-소개)
2. [개발 기간](#calendar-개발기간)
3. [기술스택](#hammer_and_wrench-기술스택)
5. [주요기능](#sparkles-주요기능)
6. [개발 환경](#computer-개발-환경)
7. [설치 및 실행 방법](#inbox_tray-설치-및-실행-방법)
<br><br>

## :star: 프로젝트 소개
**Routine-Project**는 iOS 앱 개발 과정을 학습하고, 사용자 중심의 루틴 관리 앱을 제작하기 위해 **[마이턴(MY TURN)](https://apps.apple.com/kr/app/%EB%A7%88%EC%9D%B4%ED%84%B4-%EB%B3%B4%EB%93%9C%EA%B2%8[…]99%EC%9D%80-%EB%A3%A8%ED%8B%B4%EA%B4%80%EB%A6%AC/id6463494452)** 앱을 클론 코딩한 프로젝트입니다.

마이턴은 사용자들의 루틴 관리를 돕는 앱으로, 직접 사용하며 영감을 받아 이를 재구성했습니다. 이번 프로젝트의 목표는 **실제 앱 분석을 통해 필수 기능을 구현하고 iOS 앱 개발 역량을 향상시키는 것**입니다.

개발 과정은 다음과 같은 체계적인 절차를 따랐습니다.  
1. 앱 분석  
2. 요구사항 정의  
3. 유스케이스 설계  
4. ERD 설계  

기존 앱에서 불필요하다고 느낀 기능은 제외하였으며, 이를 통해 **사용자 경험과 효율성을 극대화한 루틴 관리 앱**을 제작했습니다.
<br><br>
## :calendar: 개발기간
- 2024.10.27.(일) ~ 진행 중
<br><br>
## :hammer_and_wrench: 기술스택

### :building_construction: 아키텍처
- MVC

### :art: UI Framworks
- UIKit
- SnapKit(Auto Layout)
<br><br>

## :sparkles: 주요기능
- **추천 루틴 표시**: `SuggestionData`를 활용하여 추천 루틴 표시
- **루틴 생성**: 선택한 루틴을 CoreData에 저장
- **날짜별 루틴 로드**: 선택한 날짜에 맞는 루틴 불러오기
<br><br>

## :computer: 개발 환경
- **Xcode**: 16
- **iOS Deployment Target**: iOS 18.0
- **iOS Tested Version**: iOS 18.0 (시뮬레이터 및 실제 기기)
<br><br>
## :inbox_tray: 설치 및 실행 방법
1. 이 저장소를 클론합니다.
```bash
git clone https://github.com/name-mun/routine-project.git
```
2. 프로젝트 디렉토리로 이동합니다.
```bash
cd routine-project

```
3. Xcode에서 `Routine.xcodeproj` 파일을 엽니다.

4. Xcode에서 빌드 후 실행합니다.
- 실행 대상에서 **iPhone Simulator** 선택
- **Cmd + R**로 실행
<br><br>

