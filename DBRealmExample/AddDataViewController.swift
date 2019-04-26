//
//  AddDataViewController.swift
//  DBRealmExample
//
//  Created by Adarsh Manoharan on 25/04/19.
//  Copyright © 2019 adarsh. All rights reserved.
//


import UIKit

class AddDataViewController: UIViewController {
    
    enum status {
        case user
        case pet
        case addPet
        case addUser
    }
    
    var valueStatus = status.addUser
    
    @IBOutlet weak var optionB: UITextField!
    @IBOutlet weak var optionA: UITextField!
    var user:User? {
        didSet{
            self.valueStatus = .user
        }
    }
    
    var pet:Pet? {
        didSet{
            self.valueStatus = .pet
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        switch valueStatus {
        
        case .user:
            self.title = "Update User"
            self.optionA.placeholder = "User Name"
            self.optionA.text = user?.name
            if let pet  = user?.pet {
                self.optionB.text = pet.name
            }
            optionB.placeholder = "Pet Name"
        case .pet:
            self.title = "Update Pet"
            self.optionA.placeholder = "Pet Name"
            self.optionA.text = pet?.name
            if let owner  = pet?.owner {
                self.optionB.text = owner.name
            }
            self.optionB.placeholder = "Owner Name"
            
        case .addUser:
            self.title = "Add User"
            self.optionA.placeholder = "User Name"
            optionB.placeholder = "Pet Name"
        case .addPet:
             self.title = "Add Pet"
             self.optionA.placeholder = "Pet Name"
             self.optionB.placeholder = "Owner Name"
        }
        
    }
    
    @IBAction func save(_ sender: Any) {
        
        if (optionA.text != nil && optionA.text!.isEmpty == false){
        
            switch valueStatus {
            case .user:
                let pet = Converters.makePet(with: self.optionB.text!, owner: nil)
                let user = Converters.makeUser(with: self.optionA.text!, pet: pet)
                Operations().updateUser(value: self.user?.name ?? "", replaceWith: user, compted: {
                    print("Updated")
                })
            case .pet:
                let user = Converters.makeUser(with: self.optionB.text!, pet: nil)
                let pet = Converters.makePet(with: self.optionA.text!, owner: user)
                Operations().updatePet(value: self.pet?.name ?? "", replaceWith: pet, compted: {
                    print("Updated")
                })
            case .addPet:
                let user = Converters.makeUser(with: self.optionB.text!, pet: nil)
                let pet = Converters.makePet(with: self.optionA.text!, owner: user)
                Operations().store(data: .pet, data: pet)
            case .addUser:
                let pet = Converters.makePet(with: self.optionB.text!, owner: nil)
                let user = Converters.makeUser(with: self.optionA.text!, pet: pet)
                Operations().store(data: .user, data: user)
            }
            self.navigationController?.popViewController(animated: true)
            
        }else{
            print("Add Some Values")
        }
        
        
    }
    
}
