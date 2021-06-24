import Foundation

public struct MealModel: Codable {
    /// 아침 🍽
    public let breakfast: [String]
    /// 점심 🍽
    public let lunch: [String]
    /// 저녁 🍽
    public let dinner: [String]
}
