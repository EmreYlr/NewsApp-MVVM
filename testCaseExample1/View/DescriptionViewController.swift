//
//  DescriptionViewController.swift
//  testCaseExample1
//
//  Created by Emre on 25.02.2024.
//

import UIKit
import Alamofire
final class DescriptionViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var contentLabel: UILabel!
    
    //MARK: VARIABLE
    var article: Article?
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = article?.title
        titleLabel.numberOfLines = 0
        contentLabel.text = article?.content
        contentLabel.numberOfLines = 0
        
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        getImage()
    }
}
//MARK: FUNCTION
extension DescriptionViewController{
    func getImage(){
        if let imageUrlString = article?.urlToImage {
            NetworkManager.shared.loadImage(from: imageUrlString) { [weak self] responseData in
                DispatchQueue.main.async {
                    self?.indicatorView.stopAnimating()
                    self?.indicatorView.isHidden = true
                    let image = UIImage(data: responseData!, scale: 1)
                    self?.imageView.image = image
                }
            }
        }
    }
}

