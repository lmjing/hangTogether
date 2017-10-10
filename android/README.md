지금 상황에서 이렇게까지 해야하나라는 생각이 들수도 있지만,

개발자면 써야할 **github가 너에게 빨리 익숙해졌으면 하는 바람 + github를 잘 쓰고 싶은 마음** 에 주절주절 정말 필요한 것만 써놓거니깐! 함 보삼

## 초기 설정
*맨 처음 한번만! 해야할 작업*
1. 해당 github clone 받기
니가 원하는 곳에 `$ git clone https://github.com/lmjing/HangTogether.git`하면 폴더 생성

2. `$ git branch` 해서 branch 목록 확인
    - `Android` branch가 **있는** 경우 : `$ git checkout Android` 해서 Android branch로 전환
    - `Android` branch **없는** 경우 : `$ git checkout -b Android` 해서 Android branch를 생성 + 전환 동시에 진행
    
    *이경우는 github에는 Android라는 branch가 있지만 니 컴에는 없어서 만들어 주는거야*

`$ git branch`로 **Android branch로 잘 이동했는지 확인!**

3. Android 폴더에 니가 작업하던 프로젝트 전체 복사(폴더 째)
*꼭 복사로! 안될 수도 있으니깐 날라가지 않게*

4. `$ git add .`로 새로운 작업물 전체 추가한 후 `$ git commit -m "하고 싶은 말(ex- 안드로이드 작업 중이던 프로젝트 추가함)"`로 commit 남김

5. `$ git push`해서 github로 올림

6. [우리 Github](https://github.com/lmjing/HangTogether)로 이동하면
![스크린샷 2017-09-26 오전 1.56.48](https://i.imgur.com/hFI9hyq.png)

이렇게 뜰거임 그럼 초록 버튼 `Compare & pull request`를 누르면 아래와 같이 뜰거임

내용을 적고 Reviewers에 톱니 바퀴를 누르면 저렇게 뜨는데 `lmjing`를 쳐서 나를 추가 하면 됨

![스크린샷 2017-09-26 오전 1.58.42](https://i.imgur.com/xeIoCzr.png)

이 내용은 *master branch에 Android에서 한 작업물을 합치고 싶어요* 라고 요청을 보내는거야

**pullrequest를 날리는 이유는 내가 올린 코드를 다른 사람들이 보고 리뷰하고 검수 받기 위해서** 

즉, merge작업은 pullrequest를 날린 사람이 하는게 아니라 Reviewers에 올라가 있는 사람들이 하는 것임

> 그래서 이렇게 올리면 내가 잘했는지 확인하고 merge할 예정이야

## 꼭 해야할 것들
### branch
`$ git branch` 쳤을 때 * 표시 되어있는게 현재 branch!

master는 제일 윗단에 중요한 branch라서 그나마 git이 익숙한 내가 관리할 예정이고, 너는 **Android** branch에서 작업하면 되는데 

master에 **pullrequest 날리는 작업은 너 기준 큰 작업단위가 완료되서 실행해봤을 때 문제가 없는 수준일 경우 하면 됨**

그 이외에는 Android에만 니 작업물 코드가 있는거야 *(당연히 master에는 안합친 상태니깐 없을거고)*

내가 홈 README에 적어놓은 것 처럼 더 세부적인 기능단위의 branch를 만들어서 그 쪽에서 작업하다가 `Android` branch에 합치는게

branch 관리를 하는 이유 중 하나이긴 하지만, 갑자기 많은걸 배워야해서 힘들다면 걍 `Android`에서 `add & push`만 해도 돼

그래도 익숙해지면 기능단위로 branch 만들고 합치고 그 기능 branch 삭제하는 과정을 거치는걸 추천!

*이렇게 하는 가장 큰 이유는 작업하다 망할 경우 돌아가기가 쉽거든*

### 개발 전 항상 해야하는 작업
어느 branch던지 `$ git pull`받고 시작하기

나중에 열심히 commit하고 push해도 니가 했던 작업이랑 github에 올라가있는 코드랑 조금이라도 다르면 안되므로 **동기화** 시키기는 작업

### Android pullrequest 날릴 때 주의
혹여 맨 위에 적은 과정 처럼 master에 pullrequest를 날렸는데, `able to merge`가 아니라 빨간색으로 merge안된다고 뜬다면

`$ git pull origin master`로 master 내용이랑 동기화 작업을 해야지만 합쳐짐

그리고 나서 conflict가 나면 해당 파일을 고치고 `$ git push`해서 다시 날리면 되는데, 문제가 생기면 그 때 다시 알려줄게

## 유용쓰
### 기능별로 branch 나누는 작업
1. `Android` branch에서 `git checkout -b [기능 branch 명]`으로 branch 생성+이동을 한다.
2. 작업 진행하면서 `$ git add .` + `$ git commit` 열심히 한다.
3. 해당 기능 완성이 다 되었다 싶으면 `$ git push`를 한다.

4. Android branch에 merge하면 됨
    - 걍 바로 합쳐도 될 것 같으면 `$ git checkout Android`로 Android branch로 다시 이동해서 `$ git merge [기능 branch 명]`하면 바로 merge 되고 그 상태로 `$ git push`해야 github Android branch에 내용 반영됨
    - 만 ~~~ 약 코드리뷰를 받고 싶거나, 잘 모르는게 있을 경우 pullrequest를 날리면 내가 확인 후 merge를 할거임
    
5. 추후에 그 기능 branch를 또 사용할 것 같다! 하면 냅두고 아니면 `$ git branch -D [기능 branch 명]`해서 삭제하면 됨

### 작업 상태 확인
- `$ git status`: add 해야할 것들 확인 *(추가 작업 내역)*
- `$ git log`: 내가 commit한 내역들 확인

### 실수한 경우 초기화
- `$ git reset`: `git add` or `git commit` 잘못해서 내용 수정하고 싶은 경우 `$ git reset`하면 코드는 그대로! 다시 `git add, commit`을 할 수 있다.
- `$ git reset --hard`: 여태까지 작업한 코드들이 다 무쓸모다! 하는 경우 코드 다 날려버릴 수 있는 방법! **조심** 해야함 !!
사용하게 되면 이전 커밋시점으로 돌아가니깐, `git log`로 이전 시점이 뭔지 확인하고 안심이 될 때만 사용할 것!
근데 이거 은근 유용함 *(commit 자주 한 경우)*

### 잠시 보관
```
$ git stash
```
작업을 이미 해버린 상태인데 이 branch가 아니여서 옮겨야 하는 경우, 또는 코딩 했는데 버리기는 아깝고 잠시 킵해두고 다른 코드 짜본 다음 되돌아 오고 싶은 경우!

`$ git stash`하면 작업 내역이 잠시 어디 보관됨 `$ git stash list`하면 확인 가능

그리고 원하는 branch로 이동한 후 등, 꺼내고 싶은 시점이 생기면 `$ git stash apply` 해서 가져오면 된다. *(pull 처럼 시점이 달라도 기존 코드랑 잘 어울리게 합쳐준다.)*

## 참고
- googledrive에 올려놓은 파일들
- git branch 기능 여러개 쉽게 학습할 수 있게 해놓은 사이트 : [learngitbranching](http://learngitbranching.js.org/)

