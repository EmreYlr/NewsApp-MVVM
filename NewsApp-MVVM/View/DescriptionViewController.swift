//
//  DescriptionViewController.swift
//  testCaseExample1
//
//  Created by Emre on 25.02.2024.
//

import UIKit

final class DescriptionViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var contentLabel: UILabel!
    
    //MARK: VARIABLE
    var descriptionViewModel: DestinationViewModelProtocol = DescriptionViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionViewModel.delegate = self
        setTextOrEmpty(descriptionViewModel.article?.title, for: titleLabel)
        setTextOrEmpty(descriptionViewModel.article?.content, for: contentLabel)
        descriptionViewModel.loadImage()
    }
    
    func setTextOrEmpty(_ text: String?, for label: UILabel) {
        label.text = text ?? "Empty \(label.accessibilityIdentifier ?? "Field")"
    }
    
}

extension DescriptionViewController: DescriptionViewModelOutputProtocol {
    func update(with data: Data?) {
        DispatchQueue.main.async {
            if let data = data {
                self.imageView.image = UIImage(data: data, scale: 1)
            }
        }
    }
    
    func startLoad() {
        indicatorView.isHidden = false
        indicatorView.startAnimating()
    }
    
    func stopLoad() {
        indicatorView.isHidden = true
        indicatorView.stopAnimating()
    }
    
    func error() {
        self.imageView.image = UIImage(named: "noResult")
        print("")
    }
}
