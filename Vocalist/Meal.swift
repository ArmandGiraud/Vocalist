//
//  Meal.swift
//  Vocalist
//
//  Created by Giraud Armand on 15/09/2018.
//  Copyright © 2018 Giraud Armand. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    
    
    //MARK: Properties
    var word: String
    var translation: String
    var example: String
    var rating: Int
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("mealskk")
    
    //MARK: Types
    
    struct PropertyKey {
        static let word = "word"
        static let translation = "translation"
        static let example = "example"
        static let rating = "rating"
    }
    //MARK: Initialization
    
    init?(word: String, translation: String, example: String,  rating: Int) {
        // Initialization should fail if there is no name or if the rating is negative.
        if word.isEmpty || rating < 0  {
            return nil
        }

        // Initialize stored properties.
        self.word = word
        self.translation = translation
        self.example = example
        self.rating = rating
        
        
    }
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(word, forKey: PropertyKey.word)
        aCoder.encode(translation, forKey: PropertyKey.translation)
        aCoder.encode(example, forKey: PropertyKey.example)
        aCoder.encode(rating, forKey: PropertyKey.rating)

    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let word = aDecoder.decodeObject(forKey: PropertyKey.word) as? String else {
            os_log("Unable to decode the word for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let translation = aDecoder.decodeObject(forKey: PropertyKey.translation) as? String else {
            os_log("Unable to decode the translation for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let example = aDecoder.decodeObject(forKey: PropertyKey.example) as? String else {
            os_log("Unable to decode the example for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        self.init(word: word, translation: translation, example: example, rating: rating)
    }
}

