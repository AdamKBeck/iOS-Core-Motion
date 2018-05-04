//
//  IndividualNoteViewController.swift
//  FinalProject
//
//  Created by Jason Harnack on 5/3/18.
//  Copyright © 2018 Jason Harnack. All rights reserved.
//

import UIKit

class IndividualNoteViewController: UIViewController {

    @IBOutlet weak var noteData: UILabel!
    @IBOutlet weak var noteDate: UILabel!
    @IBOutlet weak var noteText: UILabel!
    var note = NoteCell()
    override func viewDidLoad() {
        super.viewDidLoad()

        noteData.text = note.noteData
        noteText.text = note.noteText
        noteDate.text = "Date Created: \(note.noteDate.toString(dateFormat: "MMM / dd / yyyy"))"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
