# Hang Together

> 목표 : 구현 / 추후 공모전 

## 기획
#### ADS
*: 주요 타겟, 자신만의 차이점, 솔루션*

**외국인 ver.**
```
국내 외국인 여행객들을 위한
한국 문화를 더 쉽고 자세하게 접할 수 있도록
모국어가 가능한 나만의 여행 가이드 찾기 앱
```

**한국인 ver.**
```
외국어를 배웠지만 활용할 기회가 없는 한국인들을 위한
외국에 나가지 않고도 국내 외국 여행객의 일일 가이드가 되어
배운 언어를 활용할 수 있는 기회를 제공해주는 앱
```

## 규칙
*회의 때 정리할 예정( 생각나는 것 있음 일단 추가하기 )*

> 디자인을 github에 올리는게 나을지, 아니면 구글 드라이브를 따로 파서 거기에 관리하는게 나을까?

#### 담당
협업으로 진행되지만, 분야별 담당자가 각 분야를 **책임지고 맡아 진행, 관리한다.**

- 최수빈 : Design, Document
- 이미정 : iOS, Backend
- 정우진 : Android

1. **프로젝트** 관리
    - `iOS / Android / Design / Backend` 폴더를 나눈 후 그 안에서 각자 생성, 관리한다.

    - Projects에 `Common / iOS / Android / Backend / Design`을 만들어 각각 할일을 정의한다.

    - 각 Project는 `TODO / Doing / Done`이 있으며 해야할 일이나 issue를 현황에 따라 정리한다.

    - 공통적으로 할일이 있다면 반드시 명시해서 모두가 확인하고 **피드백** 줄 수 있드록 관리한다.

    - 분업시 자신이 맡은 일에 대해선 반드시 기록할 필요는 없다.
      개인적으로 관리하거나 정리할 용도로 만들어 놓았을 뿐.
      
2. **Branch** 관리
    - 크게 `iOS / Android / Backend / Design`으로 나눠 진행하며 각 branch는 각 **담당자가 관리** 한다.
    - 개발은 View 혹은 기능단으로 나누어 개발한 후, `iOS / Android / Backend` branch에 merge한다.
      - 각 담당자면 바로 merge
      - 그 외의 사람들이 merge를 해야할 경우, 각 branch에 **pullrequest** 를 날려 담당자가 확인 후 merge한다.
    - master는 버전별 최종 코드(clone 받아서 실행했을 때 문제 없는 정도)만 소유해 버전관리를 한다. 
    - 이전 코드들은 develop에서 합친다. 즉, pullrequest base는 develop이다.
      - `iOS / Android / Backend`에서 devlop에 pullrequest를 날리면, lmjing이 검토 후 merge한다.
      -  예외 : Design과 같이 **공유해야할 파일들** 은 즉시 master에 merge해 업로드한다.
    - 개발 전 remote와 working directory 동기화 하고 작업한다.
    - branch명은 Android, iOS가 View와 기능이 같아 겹칠 가능성이 있으므로 **규칙을 정해** 겹치지 않게 한다.
      `ex ) Login_and / Login_ios`
    - commit은 최대한 자주 남겨서 효율적인 코드 관리를 할 수 있도록 한다.

3. **Issue** 관리

    - 개발 혹은 기획 중 혼자 해결이 어려운 경우 또는 오래 걸릴 것 같은 문제에 대한 issue를 등록한다.
    - issue에 대해 서로 피드백을 comment로 남기거나 해결 방안을 작성한다.
    - commit을 할 때 #[issueNum] 을 적어 관련 코드를 확인할 수 있게 한다.
      ex) `$ git commit -m "로그인 문제 발생 #2"`
    - issue가 해결 된 경우 수동으로 닫거나 commit을 활용해 issue를 닫는다.
      commit으로 닫는 방법 : `close #[issueNum]` [(참고)](http://minsone.github.io/git/github-commits-closing-issues-via-commit-messages)
      *하지만 master에 merge되어야지만 닫히기 때문에, commit에 표시한 후 해결된 즉시 수동으로 닫는 것이 더 좋을 듯 하다.*

4. **gitignore**
    - 각 프로젝트 폴더별로 github에 올리지 않을 내용을 정의한다.
      [gitignore.io](https://www.gitignore.io/)을 활용한다.
    - API Key, Server Address 등 중요한 데이터는 **Config** 파일을 따로 생성해 해당 파일에 작성한 후 꺼내 쓴다.
      **Config 파일을 .gitignore에 추가해 github에 올라가지 않게 한다.**
      해당 파일은 따로 보관하여 새로 clone을 받거나 pull을 받은 경우 수동으로 추가한다.

