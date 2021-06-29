import Foundation

internal enum StatusCode: Error {

    /// 400 :: 올바르지 않은 요청 ⛔️
    case badRequest

    /// 500 :: 서버 에러 ⛔️
    case internalServerError

    /// ? :: 알수 없는 에러 ⛔️
    case unkown

}
