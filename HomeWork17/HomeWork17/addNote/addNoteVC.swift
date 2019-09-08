//
//  TargetNoteVC.swift
//  HomeWork17
//
//  Created by Pavel Procenko on 05/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit
import Foundation
class addNoteVC: UIViewController {
    
   
    @IBOutlet weak var text: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveNote(_ sender: Any) {
        
        guard !text.text.isEmpty else {
            navigationController?.popViewController(animated: true)
            return
        }
        CoreDataManager.shared.addNote(Date(), text.text)
        navigationController?.popViewController(animated: true)
        
    }
    
    
}

