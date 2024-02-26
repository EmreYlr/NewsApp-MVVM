//
//  HomeViewModel.swift
//  testCaseExample1
//
//  Created by Emre on 25.02.2024.
//

import Foundation

final class HomeViewModel {
    private let url = NetworkHelper.BASE_URL
    private let apiKey = NetworkHelper.API_KEY
    
    func fetchData(completion: @escaping((News?, String?) -> Void)) {
        if let apiUrl = URL(string:"\(url)/top-headlines?country=us\(apiKey)"){
            NetworkManager.shared.request(from: apiUrl, method: .get) { (result: Result<News, ErrorTypes>) in
                switch result {
                case .success(let data):
                    //print(data)
                    completion(data, nil)
                case .failure(let error):
                    //print("Hata: \(error)")
                    completion(nil,error.rawValue)
                }
            }
        }
    }
}
