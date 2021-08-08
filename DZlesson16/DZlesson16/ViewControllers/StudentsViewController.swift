//
//  StudentsViewController.swift
//  DZlesson16
//
//  Created by Янина on 8.08.21.
//

import UIKit

class StudentsViewController: UIViewController {
    
    @IBOutlet weak var studentTableView: UITableView!
    
    var students: [Students] = []
    var rating5: [Students] = []
    var rating4: [Students] = []
    var rating3: [Students] = []
    var rating2: [Students] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        studentTableView.dataSource = self
        studentTableView.delegate = self
        studentTableView.tableFooterView = UIView()
        studentTableView.register(UINib(nibName: "CellTableView", bundle: nil), forCellReuseIdentifier: "CellTableView")
    
        let nameStudents = ["Lesha","Anya","Olya","Tanya","Yana","Ira","Misha","Dasha","Sasha","Vitya","Anya","Mila","Lera","Masha","Grisha","Nikita","Nastya","Olya","Anton","Andrey","Sergei","Vitalic","Maxim","Kolya","Yana","Nikita","Egor","Olya","Maxim","Sergei"]
        
        for i in 0..<nameStudents.count {
            students.append(Students.init(name: "\(nameStudents[i])", range: .random(in: 2...5)))
        }
        
        students = students.sorted { $0.name.lowercased() < $1.name.lowercased()}
        
        
        for i in 0...students.count - 1 {
            switch students[i].range {
            case 5:
                rating5.append(students[i])
            case 4:
                rating4.append(students[i])
            case 3:
                rating3.append(students[i])
            case 2:
                rating2.append(students[i])
            default:
                return
            }
        }
    }
}

extension StudentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return rating5.count
        case 1:
            return rating4.count
        case 2:
            return rating3.count
        case 3:
            return rating2.count
        default: return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Rating 5"
        case 1:
            return "Rating 4"
        case 2:
            return "Rating 3"
        case 3:
            return "Rating 2"
        default: return ""
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellTableView") as? CellTableView else { return UITableViewCell() }
        
        if indexPath.section == 0 {
         cell.setDataStudents(whith: rating5[indexPath.row])
         }
        if indexPath.section == 1 {
         cell.setDataStudents(whith: rating4[indexPath.row])
         }
        if indexPath.section == 2 {
         cell.setDataStudents(whith: rating3[indexPath.row])
         }
        if indexPath.section == 3 {
         cell.setDataStudents(whith: rating2[indexPath.row])
         }
        
        cell.namelabel.textColor = (cell.label.text == "2" || cell.label.text == "3") ? .red : .black
        cell.selectionStyle = .none
        
        return cell
    }
}

extension StudentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

