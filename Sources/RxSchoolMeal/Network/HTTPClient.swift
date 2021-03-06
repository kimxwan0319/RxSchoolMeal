import Foundation
import RxSwift
import Alamofire
import RxAlamofire

internal class HTTPClient {
    internal static let shared = HTTPClient()

    internal func networking<T: Codable>(_ api: SchoolMealAPI, _ networkModel: T.Type) -> Single<T> {
        requestData(api.method, api.uri,
                    parameters: api.parameters,
                    encoding: api.encoding,
                    headers: api.header)
            .asSingle()
            .flatMap { response, data -> Single<T> in
                return Single<T>.create { single in
                    switch response.statusCode {
                    case 200, 201:
                        do {
                            let processedData: T = try JSONDecoder().decode(T.self, from: data)
                            single(.success(processedData))
                        } catch let error {
                            single(.failure(error))
                        }
                    case 400: single(.failure(StatusCode.badRequest))
                    case 500: single(.failure(StatusCode.internalServerError))
                    default: single(.failure(StatusCode.unkown))
                    }
                    return Disposables.create()
                }
            }
    }
}
