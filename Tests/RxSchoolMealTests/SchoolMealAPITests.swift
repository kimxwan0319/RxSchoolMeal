import XCTest
import RxSwift
@testable import RxSchoolMeal

final class SchoolMealAPITests: XCTestCase {

    var disposeBag = DisposeBag()

    override func setUpWithError() throws {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue("G10", forKey: "ATPT-OFCDC-SC-CODE")
        userDefaults.setValue("7430310", forKey: "SD_SCHUL_CODE")
    }
    
    override func tearDownWithError() throws {
        disposeBag = DisposeBag()
    }

    func testGetSchoolInfo() throws {
        let expt = expectation(description: "Waiting done harkWork...")
        HTTPClient.shared.networking(.getSchoolInfo(schoolName: "대덕소프트웨어마이스터고"),
                                     SchoolInfoModel.self)
            .subscribe(onSuccess: { _ in
                XCTAssertTrue(true)
                expt.fulfill()
            }, onFailure: { error in
                switch error as? StatusCode {
                case .badRequest:
                    XCTFail("400 - badRequest Error")
                case .unauthorized:
                    XCTFail("401 - unauthorized Error")
                case .forbidden:
                    XCTFail("402 - forbidden Error")
                case .notFound:
                    XCTFail("404 - notFound Error")
                case .internalServerError:
                    XCTFail("500 - internalServerError Error")
                default:
                    XCTFail("Unkown Error")
                expt.fulfill()
                }
            })
            .disposed(by: disposeBag)
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testGetSchoolMeal() throws {
        let expt = expectation(description: "Waiting done harkWork...")
        HTTPClient.shared.networking(.getMeal(date: .today), MealModel.self)
            .subscribe(onSuccess: { _ in
                XCTAssertTrue(true)
                expt.fulfill()
            }, onFailure: { error in
                switch error as? StatusCode {
                case .badRequest:
                    XCTFail("400 - badRequest Error")
                case .unauthorized:
                    XCTFail("401 - unauthorized Error")
                case .forbidden:
                    XCTFail("402 - forbidden Error")
                case .notFound:
                    XCTFail("404 - notFound Error")
                case .internalServerError:
                    XCTFail("500 - internalServerError Error")
                default:
                    XCTFail("Unkown Error")
                expt.fulfill()
                }
            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}

