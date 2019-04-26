//
//  Pet.swift
//  DBRealmExample
//
//  Created by Adarsh Manoharan on 26/04/19.
//  Copyright © 2019 adarsh. All rights reserved.
//

import Foundation
import RealmSwift

class Pet:Object {
    
    @objc dynamic var name = ""
    @objc dynamic var owner: User?
}

