//
//  Results+CoreDataProperties.swift
//  DZlesson15
//
//  Created by Янина on 19.10.21.
//
//

import Foundation
import CoreData


extension Results {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Results> {
        return NSFetchRequest<Results>(entityName: "Results")
    }

    @NSManaged public var data: String?
    @NSManaged public var winner: String?
    @NSManaged public var playerBlack: String?
    @NSManaged public var playerWhite: String?

    func convert (by results: ResultsModel) {
        self.data = results.data_m
        self.winner = results.winner_m
        self.playerBlack = results.playerBlack_m
        self.playerWhite = results.playerWhite_m
    }
}

extension Results : Identifiable {

}
