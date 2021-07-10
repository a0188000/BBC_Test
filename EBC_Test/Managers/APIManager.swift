//
//  APIManager.swift
//  EBC_Test
//
//  Created by 沈維庭 on 2021/7/9.
//

import Foundation
import Alamofire

class APIManager {
    static let shared = APIManager()
    
    func request<T: Codable>(req: URLRequestConvertible,
                                     completionHandler: @escaping (Swift.Result<T, Error>) -> Void) {
        Alamofire.request(req).responseData { (response) in
            guard let data = response.data else {
                completionHandler(.failure(response.error!))
                return
            }
            do {
                let itunes = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(itunes))
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
}
