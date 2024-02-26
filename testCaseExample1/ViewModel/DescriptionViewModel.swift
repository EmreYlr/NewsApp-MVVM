//
//  DescriptionViewModel.swift
//  testCaseExample1
//
//  Created by Emre on 26.02.2024.
//

import Foundation
final class DescriptionViewModel{
    func loadImage(from url: String, completion: @escaping (Data?, String?) -> Void){
        if let url = URL(string: url){
            NetworkManager.shared.requestData(from: url, method: .get) {result in
                switch result{
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
