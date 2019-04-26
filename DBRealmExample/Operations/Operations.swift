//
//  Pet.swift
//  DBRealmExample
//
//  Created by Adarsh Manoharan on 26/04/19.
//  Copyright © 2019 adarsh. All rights reserved.
//


import Foundation
import RealmSwift

class Operations {
    
    let realm = try? Realm()
    
    func store(data withtype: storeType , data: AnyObject) {
        guard let realm = realm else {return}
        switch withtype {
        case .pet:
            guard let data = data as? Pet else {return}
            try! realm.write {
                realm.add(data)
            }
            
        case .user:
            guard let data = data as? User else {return}
            try! realm.write {
                realm.add(data)
            }
        }
    }
    
    
    func getUsers() -> Results<User>?  {
        let result: Results<User>? = realm?.objects(User.self)
        return result
    }
    
    func getPets() -> Results<Pet>?  {
        let result: Results<Pet>? = realm?.objects(Pet.self)
        return result
    }
    
    func updateUser(value:String,replaceWith: User, compted:@escaping() -> Void){
        
        let predicate = NSPredicate(format: "name == %@", value)
        if let user = realm?.objects(User.self).filter(predicate).first
        {
            try? realm?.write {
                user.name = replaceWith.name
                user.pet = replaceWith.pet
                compted()
            }
        }
    }
    
    func updatePet(value:String,replaceWith: Pet, compted:@escaping() -> Void){
        
        let predicate = NSPredicate(format: "name == %@", value)
        if let user = realm?.objects(Pet.self).filter(predicate).first
        {
            try? realm?.write {
                user.name = replaceWith.name
                user.owner = replaceWith.owner
                compted()
            }
        }
    }
    
    func deleteUser(value:String, compted:@escaping() -> Void){
        
        let predicate = NSPredicate(format: "name == %@", value)
        if let user = realm?.objects(User.self).filter(predicate)
        {
            try! realm?.write {
                user.forEach({
                    realm?.delete($0)
                    compted()
                })
            }
        }
    }
    func deletePet(value:String, compted:@escaping() -> Void){
        
        let predicate = NSPredicate(format: "name == %@", value)
        if let user = realm?.objects(Pet.self).filter(predicate)
        {
            try! realm?.write {
                user.forEach({
                    realm?.delete($0)
                })
            }
            compted()
        }
    }
    
    func deleteAllData(){
        try! realm?.write {
           realm?.deleteAll()
        }
    }
    
    
    
}
