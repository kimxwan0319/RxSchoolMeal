import Foundation

public struct SchoolInfoModel: Codable {
    /// 시도교육청코드
    public let ATPT_OFCDC_SC_CODE: String
    /// 표준학교코드
    public let SD_SCHUL_CODE: String
    /// 학교이름
    public let SCHUL_NM: String
}
