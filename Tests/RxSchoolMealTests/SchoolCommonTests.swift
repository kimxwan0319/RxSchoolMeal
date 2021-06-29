import XCTest
import RxSwift
@testable import RxSchoolMeal

final class SchoolCommonTests: XCTestCase {

    var disposeBag = DisposeBag()
    
    override func tearDownWithError() throws {
        disposeBag = DisposeBag()
        SchoolCommon.shared = SchoolCommon()
        let userDefault = UserDefaults.standard
        userDefault.removeObject(forKey: "ATPT_OFCDC_SC_CODE")
        userDefault.removeObject(forKey: "SD_SCHUL_CODE")
        userDefault.removeObject(forKey: "SCHUL_NM")
    }
    
    func testInitSchool() throws {
        let expt = expectation(description: "Waiting done harkWork...")
        let schoolName = "대덕소"
        SchoolCommon.initSchool(schoolName: schoolName)
        SchoolCommon.shared.isSet?.subscribe(onSuccess: {
            XCTAssertTrue(SchoolCommon.shared.school_information!.SCHUL_NM.contains(schoolName))
            expt.fulfill()
        }, onFailure: { err in
            XCTFail(err.localizedDescription)
            expt.fulfill()
        })
        .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testInitSchoolWithSaved() {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue("G10", forKey: "ATPT_OFCDC_SC_CODE")
        userDefaults.setValue("7430310", forKey: "SD_SCHUL_CODE")
        userDefaults.setValue("대덕소프트웨어마이스터고등학교", forKey: "SCHUL_NM")
        let expt = expectation(description: "Waiting done harkWork...")
        let schoolName = "대덕소"
        SchoolCommon.initSchool(schoolName: schoolName)
        SchoolCommon.shared.isSet?.subscribe(onSuccess: {
            XCTAssertTrue(SchoolCommon.shared.school_information!.SCHUL_NM.contains(schoolName))
            expt.fulfill()
        }, onFailure: { err in
            XCTFail(err.localizedDescription)
            expt.fulfill()
        })
        .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testCommonError() {
        let expt = expectation(description: "Waiting done harkWork...")
        let schoolName = "대마고"
        SchoolCommon.initSchool(schoolName: schoolName)
        SchoolCommon.shared.isSet?.subscribe(onSuccess: {
            XCTFail("있는 학교입니다.")
            expt.fulfill()
        }, onFailure: { err in
            XCTAssertTrue(true)
            expt.fulfill()
        })
        .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}
