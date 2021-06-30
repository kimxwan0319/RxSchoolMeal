import XCTest
@testable import RxSchoolMeal
    
final class ErrorTests: XCTestCase {
    func testStatusCodeLocalizedError() throws {
        var statusCode = StatusCode.badRequest
        XCTAssertEqual(statusCode.localizedDescription, "학교이름이 잘못 되었습니다.")
        statusCode = StatusCode.internalServerError
        XCTAssertEqual(statusCode.localizedDescription, "서버에 문제가 있네요.. 죄송합니다ㅠㅠ")
        statusCode = StatusCode.unkown
        XCTAssertEqual(statusCode.localizedDescription, "알 수 없는 에러가 발생하였습니다.")
    }
}
