//
//  TargetVC.swift
//  HomeWork17
//
//  Created by Pavel Procenko on 06/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit

class TargetVC: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save(_:)))
        
        textView.text = note?.text
    }
    
    @objc func save(_ sender: UIBarButtonItem){
        
        guard !textView.text.isEmpty else {
            
            CoreDataManager.shared.deleteNote(note: note!)
            navigationController?.popViewController(animated: true)
            return
        }
        CoreDataManager.shared.editNote(note!, Date(), textView.text)        
        navigationController?.popViewController(animated: true)
    }
}
