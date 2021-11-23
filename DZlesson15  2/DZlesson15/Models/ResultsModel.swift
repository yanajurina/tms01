//
//  ResultsModel.swift
//  DZlesson15
//
//  Created by Янина on 19.10.21.
//

import UIKit
class ResultsModel {
    
    var data_m: String?
    var winner_m: String?
    var playerWhite_m: String?
    var playerBlack_m: String?
    
    init (data_m: String?, winner_m: String?, playerWhite_m: String?, playerBlack_m: String?) {
        self.data_m = data_m
        self.winner_m = winner_m
        self.playerWhite_m = playerWhite_m
        self.playerBlack_m = playerBlack_m
    }
    
    init (from results: Results) {
        self.data_m = results.data
        self.winner_m = results.winner
        self.playerWhite_m = results.playerWhite
        self.playerBlack_m = results.playerBlack
    }
}
