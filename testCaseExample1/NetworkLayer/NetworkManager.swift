//
//  NetworkManager.swift
//  testCaseExample1
//
//  Created by Emre on 25.02.2024.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    func request<T: Codable>(from url: URL ,method: HTTPMethods ,completion: @escaping(Result<T, ErrorTypes>) -> Void){
        AF.request(url, method: method.toAlamofire()).responseDecodable(of: T.self){ response in
            switch response.result{
            case .success(let value):
                completion(.success(value))
            case .failure(_):
                completion(.failure(.invalidURL))
                break
            }
        }
    }
    func requestData(from url: URL ,method: HTTPMethods ,completion: @escaping(Result<Data?, ErrorTypes>) -> Void){
        AF.request(url, method: method.toAlamofire()).response{ response in
            switch response.result{
            case .success(let value):
                completion(.success(value))
            case .failure(_):
                completion(.failure(.invalidURL))
                break
            }
        }
    }
}
