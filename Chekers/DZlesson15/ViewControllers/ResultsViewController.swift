//
//  ResultsViewController.swift
//  DZlesson15
//
//  Created by Янина on 1.08.21.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var tableViewResults: UITableView!
    @IBOutlet weak var customBackButton: CustomButton!
    
    var currentLanguage: Language = .english
    var results: [ResultsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        results = CoreDataManager.shared.getResults()
        customBackButton.delegate = self
        setupTableView()
    }
    
    func setupTableView() {
        tableViewResults.dataSource = self
        tableViewResults.delegate = self
        tableViewResults.register(UINib(nibName: "TableViewCellResults", bundle: nil), forCellReuseIdentifier: "TableViewCellResults")
        tableViewResults.tableFooterView = UIView()
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        CoreDataManager.shared.deleteGroup()
        results.removeAll()
        tableViewResults.reloadData()
    }
}

extension ResultsViewController: CustomBattonDelegate {
    func buttonDidTap(_ sender: CustomButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellResults") as? TableViewCellResults else { return UITableViewCell() }
        cell.dataLabel.text = self.results[indexPath.row].data_m
        cell.whitePlayer.text = self.results[indexPath.row].playerWhite_m
        cell.blackPlayer.text = self.results[indexPath.row].playerBlack_m
        cell.winnerLabel.text = "Winner - \(self.results[indexPath.row].winner_m ?? "")"
        return cell
    }
}

extension ResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
