//
//  CoreData.swift
//  HomeWork17
//
//  Created by Pavel Procenko on 06/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager: NSObject {
    
    //MARK: - Singleton
    static let shared = CoreDataManager()
    
    //MARK: - Get
    var notes: [Note]{
        get{
            if let notes = try? context.fetch(Note.fetchRequest()) as? [Note]{
                return notes
            }else{
                return []
            }
        }
    }
    
    //MARK: - Add
    func addNote(_ date: Date,_ text: String){
        
        let note = Note(context: context)
        
        note.date = date
        note.text = text
        
        saveContext()
        print("Сохранено",notes.count)
        
        
    }
    
    func editNote(_ note: Note,_ date: Date,_ text: String){
        
        note.date = date
        note.text = text
        
        saveContext()
    }
    
    func deleteNote(note: Note) {
        context.delete(note)
        
        saveContext()
    }
    
    
    //MARK: - Core data
    var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "HomeWork17")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    // MARK: - Core Data Saving support
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
}
