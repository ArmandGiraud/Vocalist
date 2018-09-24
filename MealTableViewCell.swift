//
//  MealTableViewCell.swift
//  Vocalist
//
//  Created by Giraud Armand on 15/09/2018.
//  Copyright © 2018 Giraud Armand. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    //MARK: properties
    @IBOutlet weak var french_place: UILabel!
    @IBOutlet weak var russian_place: UILabel!
    @IBOutlet weak var example_place: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
