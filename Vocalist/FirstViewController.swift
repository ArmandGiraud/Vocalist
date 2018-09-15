//
//  FirstViewController.swift
//  Vocalist
//
//  Created by Giraud Armand on 11/09/2018.
//  Copyright © 2018 Giraud Armand. All rights reserved.
//

import UIKit
import os.log


class FirstViewController: UIViewController, UITextFieldDelegate {
    //MARK: properties
    @IBOutlet weak var edit_title: UILabel!
    @IBOutlet weak var label_french: UILabel!
    @IBOutlet weak var french_text: UITextField!
    @IBOutlet weak var label_russian: UILabel!
    @IBOutlet weak var russian_text: UITextField!
    @IBOutlet weak var save_button: UIButton!
    
    //MARK: Navigation
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === save_button else {
            
            let word = french_text.text ?? ""
            let translation = russian_text.text ?? ""
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            // Set the meal to be passed to MealTableViewController after the unwind segue.
            meal = Meal(word: word, translation: translation, rating: 0)
            
            return
        }
    }

    
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        disable  the save button
        updateSaveButtonState()
        
        russian_text.delegate = self
        french_text.delegate = self
        
        //edit_title.backgroundColor = UIColor.blueColor()
        edit_title.layer.cornerRadius = 8.0
        edit_title.clipsToBounds = true
        
        label_french.layer.cornerRadius = 6.0
        label_french.clipsToBounds = true
        
        label_russian.layer.cornerRadius = 6.0
        label_russian.clipsToBounds = true
        
        label_russian.layer.cornerRadius = 6.0
        label_russian.clipsToBounds = true
        
        save_button.layer.cornerRadius = 10.0
        save_button.clipsToBounds = true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }

    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        save_button.isEnabled = false
    }
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let french = french_text.text ?? ""
        save_button.isEnabled = !french.isEmpty
    }


}

