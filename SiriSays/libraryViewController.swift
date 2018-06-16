//
//  libraryViewController.swift
//  SiriSays
//
//  Created by Steve T on 8/18/15.
//  Copyright © 2015 Steve T. All rights reserved.
//

import Foundation
import UIKit

class LibraryViewController: UITableViewController {
    
    
        var Library: [Phrase] = Phrase.all()
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeue the cell from our storyboard
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhraseCell")!
        
        
         cell.textLabel?.text = Library[indexPath.row].objective 
        
        
        // return cell so that Table View knows what to draw in each row
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Library = Phrase.all()
        return Library.count
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        Library[indexPath.row].destroy()
        Library.remove(at: indexPath.row)
        tableView.reloadData()
    }
}
