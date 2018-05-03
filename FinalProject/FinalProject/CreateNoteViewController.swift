//
//  CreateNoteViewController.swift
//  FinalProject
//
//  Created by Jason Harnack on 5/2/18.
//  Copyright © 2018 Jason Harnack. All rights reserved.
//

import UIKit
import CoreData

class CreateNoteViewController: UIViewController {

    @IBOutlet weak var DataLabel: UILabel!
    @IBOutlet weak var noteText: UITextField!
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "NoteData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()
    lazy var context = persistentContainer.viewContext
    lazy var entity = NSEntityDescription.entity(forEntityName: "Notes", in: context)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CreateNote(_ sender: Any) {
            let newNote = NSManagedObject(entity: entity!, insertInto: context)
            newNote.setValue(noteText.text!, forKey: "noteText")
            newNote.setValue(Date(), forKey: "noteDate")
            newNote.setValue("test", forKey: "noteData")
        
        do {
            try context.save()
        } catch {
            print("Failed save")
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
