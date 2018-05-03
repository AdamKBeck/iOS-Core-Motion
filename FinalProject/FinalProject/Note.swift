//
//  Note.swift
//  FinalProject
//
//  Created by Jason Harnack on 5/2/18.
//  Copyright © 2018 Jason Harnack. All rights reserved.
//

import UIKit

class Note {

  public var NoteText = String()
  public var NoteDate = Date()
  public var NoteData = String()
  
  public init(){
    
  }
  
  public init(NoteText: String, NoteDate: Date, NoteData: String) {
    self.NoteText = NoteText
    self.NoteDate = NoteDate
    self.NoteData = NoteData
  }
}
