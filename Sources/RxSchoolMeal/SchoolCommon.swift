import Foundation
import RxSwift

/**
 RxSchoolMeal을  설정하는 클래스 입니다.
 
 싱글톤으로 제공되는 인스턴스를 사용해야 하며 다음과 같이 초기화할 수 있습니다.

     func application(_ application: UIApplication,
                      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
 
        SchoolCommon.initSchool(schoolName: "<#학교이름#>")
 
        return true
     }
 */
final public class SchoolCommon {
    public static var shared = SchoolCommon()

    private var disposeBag = DisposeBag()

    /// 학교 정보를 저장하는 프로퍼티 입니다.
    ///
    /// 옵셔널 타입이고, 학교정보가 세팅되지 않았을때 `nil`을 반환합니다.
    private(set) var school_information: SchoolInfoModel?
    /// 학교 정보가 설정되었을때 .success()를 넘겨줄 Single입니다.
    internal var isSet: Single<Void>!

    /**
     앱에 학교를 등록하는 메소드 입니다.
     
     - parameters:
        - schoolName: 학교 이름
     */
    public static func initSchool(schoolName: String) {
        SchoolCommon.shared.initialize(schoolName)
    }

    private func initialize(_ schoolName: String){
        isSet = Single<Void>.create { single in
            // userDefaults에 학교 정보가 저장되어있으면 저장된 정보로 세팅하고 아니다면 API를 호출하여 학교정보를 세팅합니다.
            if self.checkSavedSchoolInfo(schoolName) {
                let userDefaults = UserDefaults.standard
                self.school_information = SchoolInfoModel(
                    ATPT_OFCDC_SC_CODE: userDefaults.string(forKey: "ATPT_OFCDC_SC_CODE")!,
                    SD_SCHUL_CODE: userDefaults.string(forKey: "SD_SCHUL_CODE")!,
                    SCHUL_NM: schoolName
                )
                single(.success(()))
            } else {
                HTTPClient.shared.networking(.getSchoolInfo(schoolName: schoolName),
                                             SchoolInfoModel.self)
                    .subscribe(onSuccess: { schoolInfo in
                        self.saveSchoolInfo(schoolInfo: schoolInfo)
                        single(.success(()))
                    }, onFailure: { error in
                        switch error as? StatusCode {
                        case .badRequest:
                            single(.failure(StatusCode.badRequest))
                            fatalError("RxSchoolMeal :: 없는 학교이름 입니다.")
                        case .internalServerError:
                            single(.failure(StatusCode.internalServerError))
                            fatalError("RxSchoolMeal :: 서버에 문제가 있네요. 죄송합니다ㅠㅠ")
                        default:
                            single(.failure(StatusCode.unkown))
                            fatalError("RxSchoolMeal :: 알 수 없는 에러입니다.")
                        }
                    })
                    .disposed(by: self.disposeBag)
            }
            return Disposables.create()
        }
    }

    /// 학교 정보를 저장하는 메서드 입니다.
    private func saveSchoolInfo(schoolInfo: SchoolInfoModel) {
        self.school_information = schoolInfo
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(schoolInfo.ATPT_OFCDC_SC_CODE, forKey: "ATPT_OFCDC_SC_CODE")
        userDefaults.setValue(schoolInfo.SD_SCHUL_CODE, forKey: "SD_SCHUL_CODE")
        userDefaults.setValue(schoolInfo.SCHUL_NM, forKey: "SCHUL_NM")
    }

    /// 학교정보가 저장되어 있는지 확인하는 메서드 입니다.
    ///
    /// 입력받은 학교 이름이 저장된 학교 이름에 포함 되어았고, 시도육청코드, 표준학교코드가 저장되어있을때 true를 반환합니다.
    private func checkSavedSchoolInfo(_ schoolName: String) -> Bool {
        let userDefaults = UserDefaults.standard
        return (userDefaults.string(forKey: "SCHUL_NM") ?? "").contains(schoolName) &&
        userDefaults.string(forKey: "ATPT_OFCDC_SC_CODE") != nil &&
        userDefaults.string(forKey: "SD_SCHUL_CODE") != nil ? true : false
    }
}
