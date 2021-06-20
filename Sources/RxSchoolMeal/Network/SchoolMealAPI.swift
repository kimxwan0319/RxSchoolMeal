import Foundation
import Alamofire

internal enum SchoolMealAPI {
    case getSchoolInfo(schoolName: String)
    case getMeal(date: MealDate)
}

extension SchoolMealAPI {
    public var uri: String {
        let baseUrl = "http://http://211.38.86.92:3004"
        return baseUrl + path
    }

    public var method: HTTPMethod {
        switch self {
        case .getSchoolInfo,
             .getMeal:
            return .get
        }
    }

    public var parameters: Parameters? {
        switch self {
        default:
            return nil
        }
    }

    public var encoding: ParameterEncoding {
        switch self.method {
        case .get:
            return URLEncoding.queryString
        default:
            return JSONEncoding.default
        }
    }

    public var header: HTTPHeaders? {
        switch self {
        default:
            return nil
        }
    }

    private var path: String {
        switch self {
        case .getSchoolInfo(let schoolName):
            return "/school?SCHUL_NM=\(encodingQuery(query: schoolName))"
        case .getMeal:
            return "/meal"
        }
    }

    private func encodingQuery(query: String) -> String {
        return query.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? query
    }
}
