//
//  Pet.swift
//  DBRealmExample
//
//  Created by Adarsh Manoharan on 26/04/19.
//  Copyright © 2019 adarsh. All rights reserved.
//


import Foundation

class Converters {
    
    //create User with Pet
    public class func makeUser(with name:String , pet : Pet?) -> User {
        let user = User()
        user.name = name
        user.pet = pet
        return user
    }
    
    //Create Pet with Owner
    public class func makePet(with petName:String , owner : User?) -> Pet {
        let pet = Pet()
        pet.name = petName
        pet.owner = owner
        return pet
    }
    
}
