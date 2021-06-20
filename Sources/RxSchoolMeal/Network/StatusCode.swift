import Foundation

internal enum StatusCode: Error {
    case OK                  // 200; 성공
    case badRequest          // 400; 올바르지 않은 요청
    case unauthorized        // 401; 토큰 인증 실패
    case forbidden           // 402; 권한 없음
    case notFound            // 404; 찾을 수 없는 경로
    case internalServerError // 500; 서버 에러
    case unkown              // 알수 없는 에러
}
