//
//  WeatherViewController.swift
//  dzWeather
//
//  Created by Янина on 12.09.21.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    var cityName: String = ""
    let urlString = "http://api.openweathermap.org/data/2.5/weather?q=Minsk&appid=54d5120f5e32033ecf6e8ef3a0970d5c"
//    let urlString = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=54d5120f5e32033ecf6e8ef3a0970d5c"
    let propertiesTitles = ("temperature", "weather", "humidity", "wind speed")
//    let valuePropertiesTitles = ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherTableViewCell")
        tableView.tableFooterView = UIView()
       
        getData()
        
        print ("cityName-\(cityName)")
    }
    
    func getData() {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else
            { return }
            
            print("json")
            print(json)
            print("response")
            print(response)
            print("error")
            print(error)
        }
        session.resume()
    }

}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell") as? WeatherTableViewCell else { return UITableViewCell() }
        if indexPath.row == 0 {
            cell.propertiesLabel.text = propertiesTitles.0
        }
        if indexPath.row == 1 {
            cell.propertiesLabel.text = propertiesTitles.1
        }
        if indexPath.row == 2 {
            cell.propertiesLabel.text = propertiesTitles.2
        }
        if indexPath.row == 3 {
            cell.propertiesLabel.text = propertiesTitles.3
        }
        cell.selectionStyle = .none
        
        return cell
    }
}

extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
