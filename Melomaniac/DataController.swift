//
//  DataController.swift
//  Melomaniac
//
//  Created by Allan Auezkhan on 29.05.2026.
//

import Combine
import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Melomaniac")
    let objectWillChange = ObservableObjectPublisher()
    
    init(){
        container.loadPersistentStores{ description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
}

