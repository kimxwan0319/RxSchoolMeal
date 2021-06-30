import XCTest
import RxSwift
@testable import RxSchoolMeal

final class RxSchoolMealTests: XCTestCase {

    var disposeBag = DisposeBag()

    override func setUpWithError() throws {
        SchoolCommon.initSchool(schoolName: "대덕소프트웨어마이스터고")
    }
    
    override func tearDownWithError() throws {
        disposeBag = DisposeBag()
        SchoolCommon.shared = SchoolCommon()
    }
    
    func testGetMeal() throws {
        let expt = expectation(description: "Waiting done harkWork...")
        MEAL.getMeal(.today).subscribe(onSuccess: { _ in
            XCTAssertTrue(true)
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
        MEAL.getMeal(.today, timePart: .breakfast).subscribe(onSuccess: { _ in
            XCTAssertTrue(true)
            expt.fulfill()
        }, onFailure: { err in
            XCTFail(err.localizedDescription)
            expt.fulfill()
        })
        .disposed(by: disposeBag)
        MEAL.getMeal(.today, timePart: .lunch).subscribe(onSuccess: { _ in
            XCTAssertTrue(true)
            expt.fulfill()
        }, onFailure: { err in
            XCTFail(err.localizedDescription)
            expt.fulfill()
        })
        .disposed(by: disposeBag)
        MEAL.getMeal(.today, timePart: .dinner).subscribe(onSuccess: { _ in
            XCTAssertTrue(true)
            expt.fulfill()
        }, onFailure: { err in
            XCTFail(err.localizedDescription)
            expt.fulfill()
        })
        .disposed(by: disposeBag)
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}
