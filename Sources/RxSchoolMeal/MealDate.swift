import Foundation

public enum MealDate {
    case today
    case anotherDate(date: Date)
    case plusMinusDay(day: Int)
}

extension MealDate {
    func dateString() -> String {
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
