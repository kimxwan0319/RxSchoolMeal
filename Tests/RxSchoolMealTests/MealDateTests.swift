import XCTest
@testable import RxSchoolMeal
    
final class MealDateTests: XCTestCase {

    var mealDate: MealDate?
    let formatter = DateFormatter()
    
    override func setUpWithError() throws {
        formatter.dateFormat = "YYYYMMdd"
    }
    
    func testToday() throws {
        mealDate = .today
        XCTAssertEqual(mealDate!.dateString(), formatter.string(from: Date()))
    }

    func testOtherDay() throws {
        mealDate = .anotherDate(date: Date())
        XCTAssertEqual(mealDate!.dateString(), formatter.string(from: Date()))
    }
    
    func testPlusMinusDay() throws {
        mealDate = .plusMinusDay(day: 0)
        XCTAssertEqual(mealDate!.dateString(), formatter.string(from: Date()))
        mealDate = .plusMinusDay(day: 1)
        XCTAssertEqual(mealDate!.dateString(), formatter.string(from: Date() + TimeInterval(86400)))
        mealDate = .plusMinusDay(day: -1)
        XCTAssertEqual(mealDate!.dateString(), formatter.string(from: Date() - TimeInterval(86400)))
    }
}

