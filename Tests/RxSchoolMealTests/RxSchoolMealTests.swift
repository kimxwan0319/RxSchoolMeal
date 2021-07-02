import XCTest
import RxSwift
@testable import RxSchoolMeal

final class RxSchoolMealTests: XCTestCase {

    var disposeBag = DisposeBag()

    var date210701: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.date(from: "20210701")!
    }
    var meal210701 = MealModel(
        breakfast: [
            "함박스테이크덮밥",
            "유부김치국",
            "소떡소떡구이",
            "나박김치",
            "바나나라떼"
        ], lunch: [
            "오색현미밥",
            "동태찌개",
            "메추리알곤약조림",
            "크래미사과오이무침",
            "돈육해선장볶음",
            "배추김치"
        ], dinner: [
            "추억의도시락",
            "바닐라파이",
            "미소장국",
            "동치미",
            "왕포도알"
        ])

    override func setUpWithError() throws {
        SchoolCommon.initSchool(schoolName: "대덕소프트웨어마이스터고")
    }
    
    override func tearDownWithError() throws {
        disposeBag = DisposeBag()
        SchoolCommon.shared = SchoolCommon()
    }
    
    func testGetMeal() throws {
        let expt = expectation(description: "Waiting done harkWork...")
        MEAL.getMeal(.anotherDate(date: date210701)).subscribe(onSuccess: {
            XCTAssertEqual($0, self.meal210701)
            expt.fulfill()
        }, onFailure: { err in
            XCTFail(err.localizedDescription)
            expt.fulfill()
        })
        .disposed(by: disposeBag)
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetBreakfast() throws {
        let expt = expectation(description: "Waiting done harkWork...")
        MEAL.getMeal(.anotherDate(date: date210701), timePart: .breakfast).subscribe(onSuccess: {
            XCTAssertEqual($0, self.meal210701.breakfast)
            expt.fulfill()
        }, onFailure: { err in
            XCTFail(err.localizedDescription)
            expt.fulfill()
        })
        .disposed(by: disposeBag)
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetLunch() throws {
        let expt = expectation(description: "Waiting done harkWork...")
        MEAL.getMeal(.anotherDate(date: date210701), timePart: .lunch).subscribe(onSuccess: {
            XCTAssertEqual($0, self.meal210701.lunch)
            expt.fulfill()
        }, onFailure: { err in
            XCTFail(err.localizedDescription)
            expt.fulfill()
        })
        .disposed(by: disposeBag)
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetDinner() throws {
        let expt = expectation(description: "Waiting done harkWork...")
        MEAL.getMeal(.anotherDate(date: date210701), timePart: .dinner).subscribe(onSuccess: {
            XCTAssertEqual($0, self.meal210701.dinner)
            expt.fulfill()
        }, onFailure: { err in
            XCTFail(err.localizedDescription)
            expt.fulfill()
        })
        .disposed(by: disposeBag)
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}
