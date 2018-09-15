//
//  Meal.swift
//  Vocalist
//
//  Created by Giraud Armand on 15/09/2018.
//  Copyright © 2018 Giraud Armand. All rights reserved.
//

import UIKit

class Meal {
    
    //MARK: Properties
    var word: String
    var translation: String
    var rating: Int
    //MARK: Initialization
    
    init?(word: String, translation: String, rating: Int) {
        // Initialization should fail if there is no name or if the rating is negative.
        if word.isEmpty || rating < 0  {
            return nil
        }

        // Initialize stored properties.
        self.word = word
        self.translation = translation
        self.rating = rating
        
        
    }
    
}

