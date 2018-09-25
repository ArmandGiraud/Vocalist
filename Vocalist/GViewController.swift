//
//  GameViewController.swift
//  Vocalist
//
//  Created by Giraud Armand on 24/09/2018.
//  Copyright © 2018 Giraud Armand. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var pickerView: UIPickerView!
    
    //MARK: Properties
    
    
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerData = ["Russian to French", "French to Russian"]
        
    }
    
    //MARK: Privates
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
}
