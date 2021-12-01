//
//  HistoryViewController.swift
//  dzWeather
//
//  Created by Янина on 14.11.21.
//

import UIKit
import RxSwift
import RxCocoa

//class ItemModel {
//    var value: Int
//
//    init(value: Int) {
//        self.value = value
//    }
//}

class HistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = BehaviorSubject<[RealmDataWeather]>(value: [])
    let disposeBag = DisposeBag()
    var items: [RealmDataWeather] = RealmManager.shared.getDataWeather()
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        let items: [RealmDataWeather] = RealmManager.shared.getDataWeather()

        tableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HistoryTableViewCell")
        dataSource.bind(to: tableView.rx.items(cellIdentifier: "HistoryTableViewCell", cellType: HistoryTableViewCell.self)) { index, model, cell in
            cell.label.text = "\(model.city)  \(model.temp) °C"
        }.disposed(by: disposeBag)
 
        dataSource
            .onNext(items)
        
        tableView.rx
            .itemSelected
            .subscribe(onNext: { indexPath in
                _ = try? self.dataSource.value()[indexPath.row]
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func buttons(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            dismiss(animated: true, completion: nil)
        case 1:
            print("clear")
//            items.removeAll()
//            tableView.reloadData()
        default:
            break
        }
    }
    
}
