import Foundation

public struct MealModel: Codable, Equatable {
    /// μμΉ¨ π½
    public let breakfast: [String]
    /// μ μ¬ π½
    public let lunch: [String]
    /// μ λ π½
    public let dinner: [String]
}
