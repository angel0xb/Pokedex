//
//  DataPersistentManager.swift
//  Pokedex
//
//  Created by Angel Rodriguez on 3/9/18.
//  Copyright © 2018 angel. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataPersitanceManager {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    func getContext() -> NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
}
