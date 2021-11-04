//
//  HttpManager.swift
//  dzWeather
//
//  Created by Янина on 30.10.21.
//

import UIKit
import Alamofire

class HttpManager {
    static let shared = HttpManager()
    
    func getData(_ onCompletion: @escaping ([DataWeather]) -> Void){
        AF.request(APIConstants.getData.rawValue, method: .get).response(queue: DispatchQueue.global(qos: .userInteractive)) { response in
            guard let data = response.data else { return }
            
            onCompletion(ParseManager.shared.parseData(data))
        }
    }
    
}
