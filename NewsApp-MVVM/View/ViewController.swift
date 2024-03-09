//
//  ViewController.swift
//  testCaseExample1
//
//  Created by Emre on 25.02.2024.
//

import UIKit

final class ViewController: UIViewController {
    //MARK: VARIABLES
    @IBOutlet weak var tableView: UITableView!
    private var homeViewModel: HomeViewModelProtocol = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        homeViewModel.delegate = self
        homeViewModel.fetchData()
    }
    
}
//MARK: TABLEVIEW
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.newsItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var context = cell.defaultContentConfiguration()
        context.text = homeViewModel.newsItem[indexPath.row].title
        context.secondaryText = homeViewModel.newsItem[indexPath.row].description
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
            let selectedArticle = homeViewModel.newsItem[selectedRow]
            destination.descriptionViewModel.article = selectedArticle
        }
    }
}

extension ViewController: HomeViewModelOutputProtocol {
    func update() {
        self.tableView.reloadData()
    }
    
    func error() {
        print("")
    }
}
