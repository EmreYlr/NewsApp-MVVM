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
    var article: Article?
    let descriptionViewModel = DescriptionViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextOrEmpty(article?.title, for: titleLabel)
        setTextOrEmpty(article?.content, for: contentLabel)
        getImage()
    }
}
//MARK: FUNCTION
extension DescriptionViewController{
    func setTextOrEmpty(_ text: String?, for label: UILabel){
        label.text = text ?? "Empty \(label.accessibilityIdentifier ?? "Field")"
    }
    
    func getImage(){
        if let imageUrlString = article?.urlToImage {
            indicatorView.isHidden = false
            indicatorView.startAnimating()
            descriptionViewModel.loadImage(from: imageUrlString) { [weak self] responseData, error in
                self?.indicatorView.stopAnimating()
                self?.indicatorView.isHidden = true
                if let response = responseData{
                    DispatchQueue.main.async {
                        let image = UIImage(data: response, scale: 1)
                        self?.imageView.image = image
                    }
                }
                else{
                    print(error!)
                }
            }
        }
        else{
            imageView.image = UIImage(named: "noResult")
            indicatorView.stopAnimating()
            indicatorView.isHidden = true
        }
    }
}

