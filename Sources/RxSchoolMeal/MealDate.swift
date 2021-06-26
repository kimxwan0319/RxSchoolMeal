import Foundation

public enum MealDate {

    /// 오늘
    case today

    /// 다른 날짜
    /// - date: 조회하고 싶은 날짜의 Date.
    case anotherDate(date: Date)

    /// 일 ±
    ///
    /// 오늘을 기준으로 + 몇일, - 몇일 이런식으로 조회할 수 있습니다.
    /// - example:
    ///     - 오늘: 0
    ///     - 내일: 1
    ///     - 어제: -1
    case plusMinusDay(day: Int)
    
}

extension MealDate {
    internal func dateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYYMMdd"
        
        switch self {
        case .today:
            return formatter.string(from: Date())
        case .anotherDate(let date):
            return formatter.string(from: date)
        case .plusMinusDay(let day):
            var date = Date()
            date += TimeInterval(day*86400)
            return formatter.string(from: date)
        }
        
        
    }
}
