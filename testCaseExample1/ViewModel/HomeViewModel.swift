//
//  HomeViewModel.swift
//  testCaseExample1
//
//  Created by Emre on 25.02.2024.
//

import Foundation

protocol HomeViewModelProtocol {
    var newsItem:[Article] { get }
    var delegate: HomeViewModelOutputProtocol? { get set }
    func fetchData()
}

protocol HomeViewModelOutputProtocol: AnyObject {
    func update()
    func error()
}

final class HomeViewModel {
    private let url = NetworkHelper.BASE_URL
    private let apiKey = NetworkHelper.API_KEY
    private(set) var newsItem:[Article] = []
    weak var delegate: HomeViewModelOutputProtocol?
    
    func fetchData() {
        if let apiUrl = URL(string:"\(url)/top-headlines?country=us\(apiKey)") {
            NetworkManager.shared.request(from: apiUrl, method: .get) { [weak self] (result: Result<News, ErrorTypes>) in
                switch result {
                case .success(let data):
                    self?.newsItem = self?.filterData(data: data) ?? []
                    self?.delegate?.update()
                case .failure(let error):
                    print("Hata: \(error)")
                    self?.delegate?.error()
                }
            }
        }
    }
    private func filterData(data: News) -> [Article] {
        return data.articles.filter { $0.title != "[Removed]" }
    }
}

extension HomeViewModel: HomeViewModelProtocol {}
