import Foundation

internal enum StatusCode: Error {

    /// 400 :: 올바르지 않은 요청 ⛔️
    case badRequest

    /// 500 :: 서버 에러 ⛔️
    case internalServerError

    /// ? :: 알수 없는 에러 ⛔️
    case unkown

}

extension StatusCode: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badRequest:
            return NSLocalizedString("학교이름이 잘못 되었습니다.", comment: "bad request")
        case .internalServerError:
            return NSLocalizedString("서버에 문제가 있네요.. 죄송합니다ㅠㅠ", comment: "internal server error")
        case .unkown:
            return NSLocalizedString("알 수 없는 에러가 발생하였습니다.", comment: "unkown")
        }
    }
}
