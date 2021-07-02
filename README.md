# RxSchoolMeal

![CI](https://github.com/kimxwan0319/RxSchoolMeal/actions/workflows/main.yml/badge.svg?event=release)
[![Version](https://img.shields.io/cocoapods/v/RxSchoolMeal.svg?style=flat)](https://cocoapods.org/pods/RxSchoolMeal)
![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)
![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-4BC51D.svg?style=flat)
[![License](https://img.shields.io/cocoapods/l/RxSchoolMeal.svg?style=flat)](https://cocoapods.org/pods/RxSchoolMeal)
[![Platform](https://img.shields.io/cocoapods/p/RxSchoolMeal.svg?style=flat)](https://cocoapods.org/pods/RxSchoolMeal)
[![codecov](https://codecov.io/gh/kimxwan0319/RxSchoolMeal/branch/main/graph/badge.svg?token=KAWST1E1TU)](https://codecov.io/gh/kimxwan0319/RxSchoolMeal)



## Usage
### 초기화
iOS 앱에서 RxSchoolMeal를 사용하려면 RxSchoolMeal 파일을 아래와 같이 임포트(import)해야 합니다. 또한 학교이름을 이용해 RxSchoolMeal를 초기화 하는 과정이 필요합니다. 다음 예제를 참고하여 AppDelegate.swift에 RxSchoolMeal를 초기화하는 코드를 추가합니다.
```swift
import RxSchoolMeal 

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool { 

ㅤ... 
    SchoolCommon.initSchool(schoolName: <#학교이름#>)
ㅤ... 
ㅤ
}
```

### 급식 정보 가져오기
급식 정보를 가져오는 코드의 기본적인 형태입니다.
```swift 
MEAL.getMeal(<#날짜#>, timePart: <#식사구분#>).subscribe(onSuccess: { meal in
    print(meal)
})
.disposed(by: disposeBag)
```

* 위 `<#날짜#>`라고 작성 되어있는 부분에는 [`MealDate`](https://github.com/kimxwan0319/RxSchoolMeal/blob/main/Sources/RxSchoolMeal/MealDate.swift)라는 이름으로 정의된 enum을 입력합니다.
  | Raw Value                  | Description                                                  |
  | -------------------------- | ------------------------------------------------------------ |
  | `.today`                   | 오늘을 나타냅니다.                                           |
  | `.anotherDate(date: Date)` | 원하는 날짜를 Date 타입으로 받습니다.                        |
  | `.plusMinusDay(day: Int)`  | 오늘을 기준으로 조회하고 싶은 날짜가 몇일 후인지, 몇일 전인지를 Int형식으로 받습니다. |
* 위 `getMeal()` 함수는 `timePart: <#식사구분#>` 부분을 작성하지 않아도 되도록 오버로딩 되어있습니다. 
  만약 [`MealModel`](https://github.com/kimxwan0319/RxSchoolMeal/blob/main/Sources/RxSchoolMeal/Model/MealModel.swift)라는 이름으로 정의된 struct로 아침, 점심, 저녁 메뉴를 모두 받고싶다면 작성하지 않으시면 됩니다. 
  하지만 아침, 점심, 저녁중 하나를 `[String]`형태로 받아보고 싶다면 작성하시면 됩니다. 
* `<#식사구분#>` 라고 작성 되어있는 부분에는 [`MealPartTime`]()이라는 이름으로 정의된 enum을 입력합니다.
  | Raw Value    | Description    |
  | ------------ | -------------- |
  | `.breakfast` | 아침밥 입니다. |
  | `.lunch`     | 점심밥 입니다. |
  | `.dinner`    | 저녁밥 입니다. |
 <details><summary><b>Examples</b></summary>
 <p>

 아래 세 예제는 모두 오늘의 급식을 조회합니다.
 ```swift
 MEAL.getMeal(.today).subscribe(onSuccess: { meal in 
    print(meal)
 }, onFailure: { err in
    print(err)
 })
 .disposed(by: disposeBag)
 ```
 ```swift
 MEAL.getMeal(.anotherDate(date: Date())).subscribe(onSuccess: { meal in
    print(meal)
 }, onFailure: { err in
    print(err)
 })
 .disposed(by: disposeBag)
 ```
 ```swift
 MEAL.getMeal(.plusMinusDay(day: 0)).subscribe(onSuccess: { meal in
    print(meal)
 }, onFailure: { err in
    print(err)
 })
 .disposed(by: disposeBag)
 ```
 아래 예제는 어제의 급식중 점심만 가져오는 예제입니다.
 ```swift
 MEAL.getMeal(.plusMinusDay(day: -1), timePart: .lunch).subscribe(onSuccess: { meal in
    print(meal)
 }, onFailure: { err in
    print(err)
 })
 .disposed(by: disposeBag)
 ```
</p>
</details>


## Installation

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)
```ruby
# Podfile
use_frameworks!

target 'YOUR_TARGET_NAME' do
    pod 'RxSchoolMeal', '1.0.3'
end
```
Replace `YOUR_TARGET_NAME` and then, in the `Podfile` directory, type:
```
$ pod install
```

### [Carthage](https://github.com/Carthage/Carthage)
Add this to `Cartfile`

```
github "kimxwan0319/RxSchoolMeal" "1.0.3"
```
```
$ carthage update
```

### [Swift Package Manager](https://github.com/apple/swift-package-manager)
```swift
// Package.swift

dependencies: [
    .package(url: "https://github.com/kimxwan0319/RxSchoolMeal", from: "1.0.3")
]
```

## Author

semicolondsmkr, kimxwan0319@naver.com

## License

RxSchoolMeal is available under the MIT license. See the LICENSE file for more info.

