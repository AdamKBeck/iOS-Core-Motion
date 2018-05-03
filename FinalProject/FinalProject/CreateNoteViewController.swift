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

    var identifier = ""
    var labelText = ""
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
    lazy var entity = NSEntityDescription.entity(forEntityName: "Note", in: context)

    override func viewDidLoad() {
        super.viewDidLoad()
        DataLabel.text = labelText
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
            newNote.setValue(labelText, forKey: "noteData")
        
        do {
            try context.save()
        } catch {
            print("Failed save")
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ReturnToMeasurement(_ sender: Any) {
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
