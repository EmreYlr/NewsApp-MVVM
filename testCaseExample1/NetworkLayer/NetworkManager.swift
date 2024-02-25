//
//  NetworkManager.swift
//  testCaseExample1
//
//  Created by Emre on 25.02.2024.
//

import Foundation
import Alamofire

final class NetworkManager{
    static let shared = NetworkManager()
    
    func request<T: Codable>(url: URL ,method: HTTPMethods ,completion: @escaping(Result<T, ErrorTypes>) -> Void){
        AF.request(url, method: method.toAlamofire()).responseDecodable(of: T.self){ response in
            switch response.result{
            case .success(let value):
                completion(.success(value))
            case .failure( _):
                completion(.failure(.invalidURL))
                break
            }
        }
    }
    func loadImage(from url: String, completion: @escaping (Data?) -> Void) {
            AF.request(url, method: .get).response { response in
                switch response.result {
                case .success(let responseData):
                    completion(responseData)
                case .failure(let error):
                    print("Error: \(error)")
                    completion(nil)
                }
            }
        }
    
}
