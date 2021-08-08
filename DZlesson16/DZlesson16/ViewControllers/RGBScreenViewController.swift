//
//  RGBScreenViewController.swift
//  DZlesson16
//
//  Created by Янина on 8.08.21.
//

import UIKit

class RGBScreenViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dataSource: [ColorNameClass] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0..<200 {
            let red = Int.random(in: 0...255)
            let green = Int.random(in: 0...255)
            let blue = Int.random(in: 0...255)
            dataSource.append(ColorNameClass(color: UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: 1.0), name: "RGB(\(red),\(green),\(blue))"))
        }

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CellTableView", bundle: nil), forCellReuseIdentifier: "CellTableView")
    }
}

extension RGBScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellTableView") as? CellTableView else { return UITableViewCell() }
        cell.setData(whith: dataSource[indexPath.row])
        return cell
    }
}

extension RGBScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


