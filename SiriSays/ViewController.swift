//
//  ViewController.swift
//  SiriSays
//
//  Created by Steve T on 8/18/15.
//  Copyright © 2015 Steve T. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    var arrayLanguages = [["English", "en-US"], ["English-Male", "en-GB"], ["Aussie English", "en-AU"],["Arabic", "ar-SA"], ["Dutch", "nl-BE"], ["Greek", "el-GR"],["Chinese", "cs-CZ"], ["French", "fr-CA"],["Hebrew", "he-IL"],["Spanish", "es-ES"], ["German", "de-DE"], ["Hindi", "hi-IN"], ["Italian", "it-IT"], ["Japanese", "ja-JP"], ["Korean", "ko-KR"], ["Polish", "pl-PL"], ["Russian", "ru-RU"], ["Thai", "th-TH"], ["Turkish", "tr-TR"]]
    //var arrayLanguages = ["English", "French", "Swift","Javo","IT", "Should","Scroll"]
    var library = Phrase.all()
    var currentlanguage = "en-US"
    
    
    @IBOutlet weak var libraryButton: UIButton!
    @IBOutlet weak var randomButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var customText: UITextField!
    
    
    @IBAction func readButton(_ sender: UIButton) {
        
        if customText.text! != ""
        {
        let string = customText.text!
        let utterance = AVSpeechUtterance(string: string)
        
        utterance.voice = AVSpeechSynthesisVoice(language: currentlanguage)
        utterance.rate = 0.1
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
         view.endEditing(true)
        }

        
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        
        if customText.text! != ""
        {
        let phrase = Phrase(obj: customText.text!)
        
        phrase.save()
        


        customText.text = ""
        view.endEditing(true)
        }
    }
    
    
    
    @IBAction func randomButton(_ sender: UIButton) {
        library = Phrase.all()
        var x = library.count
        x = Int(arc4random_uniform(UInt32(x)))
        
        
        let string = library[x].objective
        let utterance = AVSpeechUtterance(string: string)
        

        utterance.voice = AVSpeechSynthesisVoice(language: currentlanguage)
        utterance.rate = 0.05
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewCell")!
        
        // if the cell has a text label, set it to the model that is corresponding to the row in array
        cell.textLabel?.text = arrayLanguages[indexPath.row][0]
        
        // return cell so that Table View knows what to draw in each row
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayLanguages.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        
        currentlanguage = arrayLanguages[indexPath.row][1]
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        randomButton.backgroundColor = UIColor.black
        randomButton.layer.cornerRadius = 15
        libraryButton.backgroundColor = UIColor.gray
        libraryButton.layer.cornerRadius = 15
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    


}

