//
//  DataTableViewCell.swift
//  DBRealmExample
//
//  Created by Adarsh Manoharan on 25/04/19.
//  Copyright © 2019 adarsh. All rights reserved.
//

import UIKit
import RealmSwift

class DataTableViewCell: UITableViewCell {

    @IBOutlet weak var optionBLabel: UILabel!
    @IBOutlet weak var optionALabel: UILabel!
    
    var user:User? {
        didSet{
            
            guard let user = user else {
                return
            }
            
            self.optionALabel.text = "User Name : " + user.name
            if let pet = user.pet {
                self.optionBLabel.text = "Pet  Name : " + pet.name
            }else{
                self.optionBLabel.text = "No Pet"
            }
        }
    }
    
    var pet:Pet? {
        didSet{
            
            guard let pet = pet else {
                return
            }
            
            self.optionALabel.text = "Pet Name : " + pet.name
            if let owner = pet.owner {
                self.optionBLabel.text = "Owner  Name : " + owner.name
            }else{
                self.optionBLabel.text = "No Owner"
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
