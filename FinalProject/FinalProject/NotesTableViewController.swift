//
//  NotesTableViewController.swift
//  FinalProject
//
//  Created by Jason Harnack on 5/2/18.
//  Copyright © 2018 Jason Harnack. All rights reserved.
//

import UIKit
import CoreData

class NotesTableViewController: UITableViewController {

    var identifier = ""
    var notes = [NoteCell]()
    var noteCells = [NoteCell]()
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
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
    
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                notes.append(NoteCell(noteData: data.value(forKey: "noteData") as! String, noteText: data.value(forKey: "noteText") as! String, noteDate: data.value(forKey: "noteDate") as! Date, cell: UITableViewCell()))
            }
        } catch {
                print("Failed")
            }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(notes.count != 0){
            return notes.count
        }
        else {
            return noteCells.count
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        if(notes.count > 0) {
            let current = notes.removeFirst()
            cell.textLabel?.text = current.noteText
            
            noteCells.append(NoteCell(noteData: current.noteData, noteText: current.noteText, noteDate: current.noteDate, cell: cell))
            
            return cell
        }
        // Configure the cell...

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let note = noteCells.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
            fetchRequest.predicate = NSPredicate.init(format: "noteDate == %@", note.noteDate as CVarArg)
            do {
                if let result = try? context.fetch(fetchRequest) {
                    for object in result {
                        context.delete(object)
                        do {
                         try context.save()
                        } catch {
                            print("unable to delete")
                        }
                    }
                }
            } 
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var dest = segue.destination as! IndividualNoteViewController
        
        if(sender is UITableViewCell){
            for cell in noteCells{
                if(sender as! UITableViewCell == cell.cell){
                    dest.note.noteData = cell.noteData
                    dest.note.noteText = cell.noteText
                    dest.note.noteDate = cell.noteDate
                }
            }
        }
    }


}
        
class NoteCell{
    var noteData = String()
    var noteText = String()
    var noteDate = Date()
    var cell = UITableViewCell()
    
    public init() {
        
    }
    
    public init(noteData: String, noteText: String, noteDate: Date, cell: UITableViewCell){
        self.noteData = noteData
        self.noteDate = noteDate
        self.noteText = noteText
        self.cell = cell
    }
}
