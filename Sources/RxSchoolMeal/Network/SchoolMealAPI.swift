import Foundation
import Alamofire

internal enum SchoolMealAPI {
    case getSchoolInfo(schoolName: String)
    case getMeal(date: MealDate)
}

extension SchoolMealAPI {
    public var uri: String {
        let baseUrl = "http://211.38.86.92:3004"
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
        return URLEncoding.queryString
//        switch self.method {
//        case .get:
//            return URLEncoding.queryString
//        default:
//            return JSONEncoding.default
//        }
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
        case .getMeal(let mealDate):
            return "/meal" +
                "?MLSV_YMD=\(mealDate.dateString())" +
                "&SD_SCHUL_CODE=\(schoolInfo.SD_SCHUL_CODE)" +
                "&ATPT_OFCDC_SC_CODE=\(schoolInfo.ATPT_OFCDC_SC_CODE)"
        }
    }

    private var schoolInfo: SchoolInfoModel {
        let userDefaults = UserDefaults.standard
        return SchoolInfoModel(
            ATPT_OFCDC_SC_CODE: userDefaults.string(forKey: "ATPT-OFCDC-SC-CODE")!,
            SD_SCHUL_CODE: userDefaults.string(forKey: "SD_SCHUL_CODE")!,
            SCHUL_NM: userDefaults.string(forKey: "SCHUL_NM")!
        )
    }

    private func encodingQuery(query: String) -> String {
        return query.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
    }
}
