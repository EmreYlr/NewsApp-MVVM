//
//  DescriptionViewModel.swift
//  testCaseExample1
//
//  Created by Emre on 26.02.2024.
//

import Foundation

protocol DestinationViewModelProtocol {
    var article: Article? { get set }
    var delegate: DescriptionViewModelOutputProtocol? { get set }
    func loadImage()
}

protocol DescriptionViewModelOutputProtocol: AnyObject {
    func update(with data: Data?)
    func startLoad()
    func stopLoad()
    func error()
}

final class DescriptionViewModel {
    var article:Article?
    weak var delegate: DescriptionViewModelOutputProtocol?
    
    func loadImage(){
        guard let url = URL(string: article?.urlToImage ?? "")else{
            self.delegate?.error()
            self.delegate?.stopLoad()
            return
        }
        self.delegate?.startLoad()
        NetworkManager.shared.requestData(from: url, method: .get) { [weak self] result in
            switch result{
            case .success(let data):
                //print(data)
                self?.delegate?.update(with: data)
            case .failure(let error):
                print("Hata: \(error)")
                self?.delegate?.error()
            }
            self?.delegate?.stopLoad()
        }
    }
}
extension DescriptionViewModel: DestinationViewModelProtocol {}
