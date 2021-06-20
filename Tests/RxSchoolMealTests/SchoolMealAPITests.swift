import XCTest
import RxSwift
@testable import RxSchoolMeal

final class SchoolMealAPITests: XCTestCase {

    var disposeBag = DisposeBag()
    
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
                    XCTFail("400 - badRequest")
                case .unauthorized:
                    XCTFail("401 - unauthorized")
                case .forbidden:
                    XCTFail("402 - forbidden")
                case .notFound:
                    XCTFail("404 - notFound")
                case .internalServerError:
                    XCTFail("500 - internalServerError")
                default:
                    XCTFail("Unkown Error")
                expt.fulfill()
                }
            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}

