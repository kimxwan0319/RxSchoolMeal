import XCTest
import RxSwift
@testable import RxSchoolMeal

final class RxSchoolMealTests: XCTestCase {

    var disposeBag = DisposeBag()
    
    var date210625: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.date(from: "20210625")!
    }
    var mealData210625 = MealModel(
        breakfast: [
            "간장계란밥",
            "시금치된장국",
            "피자소스함박",
            "깍두기",
            "비요뜨(초코링)"
        ], lunch: [
            "참치마요주먹밥",
            "초계국수",
            "찐만두",
            "풋고추쌈장무침",
            "열무김치",
            "오렌지"
        ],
        dinner: []
    )

    override func setUpWithError() throws {
        SchoolCommon.initSchool(schoolName: "대덕소")
    }
    
    override func tearDownWithError() throws {
        disposeBag = DisposeBag()
        SchoolCommon.shared = SchoolCommon()
    }
    
    func testGetMeal() throws {
        let expt = expectation(description: "Waiting done harkWork...")
        MEAL.getMeal(.anotherDate(date: date210625)).subscribe(onSuccess: { meal in
            XCTAssertEqual(meal, self.mealData210625)
            expt.fulfill()
        }, onFailure: { err in
            XCTFail(err.localizedDescription)
            expt.fulfill()
        })
        .disposed(by: disposeBag)
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetOneTimeMeal() throws {
        let expt = expectation(description: "Waiting done harkWork...")
        MEAL.getMeal(.anotherDate(date: date210625), timePart: .lunch).subscribe(onSuccess: { meal in
            XCTAssertEqual(meal, self.mealData210625.lunch)
            expt.fulfill()
        }, onFailure: { err in
            XCTFail(err.localizedDescription)
            expt.fulfill()
        })
        .disposed(by: disposeBag)
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}
