import XCTest
import RxSwift
@testable import RxSchoolMeal

final class SchoolMealAPITests: XCTestCase {

    var disposeBag = DisposeBag()
    
    override func tearDownWithError() throws {
        disposeBag = DisposeBag()
    }

    func testGetSchoolInfoApi() throws {
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

    func testGetSchoolMealApi() throws {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue("대덕소프트웨어마이스터고", forKey: "SCHUL_NM")
        userDefaults.setValue("G10", forKey: "ATPT_OFCDC_SC_CODE")
        userDefaults.setValue("7430310", forKey: "SD_SCHUL_CODE")
        let expt = expectation(description: "Waiting done harkWork...")
        HTTPClient.shared.networking(.getMeal(date: .today), MealModel.self)
            .subscribe(onSuccess: { _ in
                XCTAssertTrue(true)
                expt.fulfill()
            }, onFailure: { error in
                switch error as? StatusCode {
                case .badRequest:
                    XCTFail("400 - badRequest Error")
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
    
    func testCombineModelandApiError() throws {
        struct strangeModel: Codable {
            let a: Int
        }
        let expt = expectation(description: "Waiting done harkWork...")
        HTTPClient.shared.networking(.getSchoolInfo(schoolName: "대덕소프트웨어마이스터고"),
                                     strangeModel.self)
            .subscribe(onSuccess: { _ in
                XCTFail("200 - Success")
                expt.fulfill()
            }, onFailure: { error in
                switch error as? StatusCode {
                case .badRequest:
                    XCTFail("400 - badRequest Error")
                case .internalServerError:
                    XCTFail("500 - internalServerError Error")
                case .unkown:
                    XCTFail("Unkown Error")
                default:
                    XCTAssertTrue(true)
                expt.fulfill()
                }
            })
            .disposed(by: disposeBag)
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}

