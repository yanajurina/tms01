//
//  CoreDataManager.swift
//  DZlesson15
//
//  Created by Янина on 19.10.21.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func addNewResults(by result_m: ResultsModel) {
        let result = Results(context: persistentContainer.viewContext)
        result.data = result_m.data_m
        result.playerWhite = result_m.playerWhite_m
        result.playerBlack = result_m.playerBlack_m
        persistentContainer.viewContext.insert(result)
        saveContext()
    }
    
    func getResults() -> [ResultsModel] {
        var array: [ResultsModel] = []
        do {
            let results = try persistentContainer.viewContext.fetch(Results.fetchRequest())
            results.forEach { result in
                guard let result = result as? Results else { return }
                array.append(ResultsModel(from: result))
            }
        } catch (let e) {
            print(e)
        }
        return array
    }
    
    func deleteGroup() {
        do {
            let results = try persistentContainer.viewContext.fetch(Results.fetchRequest())
            results.forEach { result in
                guard let result = result as? Results else { return }
            persistentContainer.viewContext.delete(result)
            saveContext()
            }
        } catch (let e) {
            print(e)
        }
    }
}
