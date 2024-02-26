//
//  ViewController.swift
//  testCaseExample1
//
//  Created by Emre on 25.02.2024.
//

import UIKit

final class ViewController: UIViewController{
    //MARK: VARIABLES
    @IBOutlet weak var tableView: UITableView!
    let homeViewModel = HomeViewModel()
    var newsItem = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchData()
    }
    
}
//MARK: FUNCTION
extension ViewController{
    func fetchData(){
        homeViewModel.fetchData { response, error in
            if let response = response{
                self.newsItem = self.filterData(data: response)
                //print(response)
            }else{
                print(error!)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    func filterData(data: News) -> [Article]{
        return data.articles.filter { $0.title != "[Removed]"}
    }
}
//MARK: TABLEVIEW
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var context = cell.defaultContentConfiguration()
        context.text = newsItem[indexPath.row].title
        context.secondaryText = newsItem[indexPath.row].description
        cell.contentConfiguration = context
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toDescriptionVC", sender: indexPath.row)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDescriptionVC", let selectedRow = sender as? Int {
            let destination = segue.destination as! DescriptionViewController
            let selectedArticle = newsItem[selectedRow]
            destination.article = selectedArticle
        }
    }
    
}

