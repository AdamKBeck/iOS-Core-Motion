//
//  CreateNoteViewController.swift
//  FinalProject
//
//  Created by Jason Harnack on 5/2/18.
//  Copyright © 2018 Jason Harnack. All rights reserved.
//

import UIKit

class CreateNoteViewController: UIViewController {

    @IBOutlet weak var DataLabel: UILabel!
    @IBOutlet weak var noteText: UITextField!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Notes", in: context)

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
            newNote.setValue(noteText.text!, forKey: "NoteText")
            newNote.setValue(Date(), forKey: "NoteDate")
            newNote.setValue(data, forKey: "NoteData")
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
