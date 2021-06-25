import Foundation
import RxSwift

public let MEAL = SchoolMeal.shared

public class SchoolMeal {
    static public let shared = SchoolMeal()

    private var disposeBag = DisposeBag()
    
    /**
     급식을 가져옵니다.
     
     - parameters:
        - date: 급식을 가져올 날짜를 입력합니다.
     */
    public func getMeal(_ date: MealDate) -> Single<MealModel> {
        SchoolCommon.shared.isSet
            .flatMap{
                return Single<MealModel>.create { single in
                    HTTPClient.shared.networking(.getMeal(date: date), MealModel.self)
                        .subscribe(onSuccess: {
                            single(.success($0))
                        }, onFailure: {
                            single(.failure($0))
                        })
                        .disposed(by: self.disposeBag)
                    
                    return Disposables.create()
                }
            }
    }
    
    /**
     급식을 가져옵니다.
     
     - parameters:
        - date: 급식을 가져올 날짜를 입력합니다.
        - timePart: 아침, 점심, 저녁중 받아올 타임파트를 입력합니다.
     */
    public func getMeal(_ date: MealDate, timePart: MealPartTime) -> Single<[String]> {
        SchoolCommon.shared.isSet
            .flatMap{
                return Single<[String]>.create { single in
                    HTTPClient.shared.networking(.getMeal(date: date), MealModel.self)
                        .subscribe(onSuccess: {
                            switch timePart {
                            case .breakfast:
                                single(.success($0.breakfast))
                            case .lunch:
                                single(.success($0.lunch))
                            case .dinner:
                                single(.success($0.dinner))
                            }
                        }, onFailure: {
                            single(.failure($0))
                        })
                        .disposed(by: self.disposeBag)
                    
                    return Disposables.create()
                }
            }
    }
}
