//
//  ShowNotesVC.swift
//  HomeWork17
//
//  Created by Pavel Procenko on 05/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ShowNotesVC: UIViewController, NSFetchedResultsControllerDelegate  {
    
    @IBOutlet weak var table: UITableView!
    
    var notes = CoreDataManager.shared.notes 
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
            
        case .delete:
            
            let note = notes[indexPath.row]
            notes.remove(at: indexPath.row)
            CoreDataManager.shared.deleteNote(note: note)
            table.reloadData()
         
        @unknown default:
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        notes = CoreDataManager.shared.notes
        table.reloadData()
    }
  
}

extension ShowNotesVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let note = notes[indexPath.row]
        
        cell.textLabel?.text = note.text
        cell.detailTextLabel?.text = maskForDate(date: note.date!, mask: "dd-MM-yyyy")
        return cell
        
    }
    private func maskForDate(date: Date, mask: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = mask
        let resultDate = dateFormatter.string(from: date)
        
        return resultDate
        
    }
}

extension ShowNotesVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "target") as? TargetVC {
            
            let note = notes[indexPath.row]
            vc.note = note
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
