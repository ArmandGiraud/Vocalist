//
//  GameViewController.swift
//  Vocalist
//
//  Created by Giraud Armand on 25/09/2018.
//  Copyright © 2018 Giraud Armand. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var roundsPicker: UIPickerView!
    @IBOutlet weak var modesPicker: UIPickerView!
    
    @IBOutlet weak var box: UIView!
    @IBOutlet weak var start_button: UIButton!
    @IBOutlet weak var translation_label: UILabel!
    @IBOutlet weak var word_placeholder: UILabel!
    @IBOutlet weak var answer_text_filed: UITextField!
    
    
    var pickerData: [String] = [String]()
    var roundsData: [String] = [String]()
    var meals = [Meal]()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        makeRound()
        get_word()
        
        modesPicker.delegate = self
        modesPicker.dataSource = self
        
        roundsPicker.delegate = self
        roundsPicker.dataSource = self
        
        pickerData = ["Russian to French", "French to Russian"]
        roundsData = ["3", "5", "10", "15", "20", "25"]


        // Do any additional setup after loading the view.
    }

    //MARK: Privates picker mode
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == modesPicker {
            return pickerData.count
        }else if pickerView == roundsPicker{
            return roundsData.count
        }else {
            return 0
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == modesPicker {
            return pickerData[row]
        }else if pickerView == roundsPicker{
            return roundsData[row]
        }else {
            return ""
        }

    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
    }
    
    func makeRound(){
        box.layer.shadowColor = UIColor.purple.cgColor
        box.layer.shadowOffset = CGSize(width: 2, height: 4.0)
        box.layer.shadowRadius = 3.0
        box.layer.shadowOpacity = 0.5
        box.layer.masksToBounds = false
        box.layer.cornerRadius = 15
        
        box.layer.borderWidth = 2.0
    }

    
    func get_word(){
        // add a if russian to french or french to russian
        // save loaded words
        meals = loadMeals()!
        let n = Int(arc4random_uniform(UInt32(Int(meals.count))))
        word_placeholder.text = meals[n].word
        
    }
    
    func loadMeals() -> [Meal]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]
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
