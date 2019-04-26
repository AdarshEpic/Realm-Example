//
//  ViewController.swift
//  DBRealmExample
//
//  Created by Adarsh Manoharan on 25/04/19.
//  Copyright © 2019 adarsh. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var listVIew: UITableView!
    
    var users:Results<User>?
    var pets :Results<Pet>?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        listVIew.delegate = self
        listVIew.dataSource = self
        
    }
    //sample data
    private func addSampleData(){
        self.createUser()
        self.createPet()
    }
    
    @IBAction func addData(_ sender: Any) {
         let destinationViewController = storyboard?.instantiateViewController(withIdentifier: "Add") as! AddDataViewController
        
        let alertController = UIAlertController(title: "Add Data To", message: "", preferredStyle: .actionSheet)
        
        let userAction = UIAlertAction(title: "User", style: .default, handler: { _ in
            destinationViewController.valueStatus = .addUser
             self.navigationController?.pushViewController(destinationViewController, animated: true)
        })
        
        
        let petAction = UIAlertAction(title: "Pet", style: .default, handler: { _ in
            destinationViewController.valueStatus = .addPet
            self.navigationController?.pushViewController(destinationViewController, animated: true)
        })
        
        alertController.addAction(userAction)
        alertController.addAction(petAction)
        
        self.present(alertController, animated: true, completion: nil)
  
    }
    
   
    
    private func createUser() {
        let pet   = Converters.makePet(with: "JACKY", owner: nil)
        let user1 = Converters.makeUser(with: "John", pet: pet)
        let user2 = Converters.makeUser(with: "Doe", pet: pet)
        let user3 = Converters.makeUser(with: "Alex", pet: pet)
        
        Operations().store(data: .user, data: user1)
        Operations().store(data: .user, data: user2)
        Operations().store(data: .user, data: user3)
        
        
    }
    
    private func createPet() {
        
        let owner = Converters.makeUser(with: "John", pet: nil)
        let pet1 = Converters.makePet(with: "Catty", owner: owner)
        let pet2 = Converters.makePet(with: "Jimmy", owner: owner)
        let pet3 = Converters.makePet(with: "Kimmi", owner: owner)

        Operations().store(data: .pet, data: pet1)
        Operations().store(data: .pet, data: pet2)
        Operations().store(data: .pet, data: pet3)
    }
    
    func getData() {
        self.users = Operations().getUsers()
        self.pets = Operations().getPets()
        self.listVIew.reloadData()
        
        if(users?.count == 0 && pets?.count == 0){
            addSampleData()
            getData()
        }
    }
    
    @IBAction func reloadData(_ sender: Any) {
        getData()
        self.listVIew.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    
    @IBAction func clearDB(_ sender: Any) {
        Operations().deleteAllData()
        self.users = nil
        self.pets = nil
        self.listVIew.reloadData()
    }
    
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationViewController = storyboard?.instantiateViewController(withIdentifier: "Add") as! AddDataViewController
        switch indexPath.section {
        case 0:
            destinationViewController.user = self.users?[indexPath.row]
            break
        case 1:
            destinationViewController.pet = self.pets?[indexPath.row]
        default:
            print("No Data Available")
        }
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            if(indexPath.section == 0) {
                Operations().deleteUser(value: self.users?[indexPath.row].name ?? "", compted: {
                    print("Deleted")
                })
            }else{
                Operations().deletePet  (value: self.pets?[indexPath.row].name ?? "", compted: {
                    print("Deleted")
                })
            }
            self.getData()
        }
        
        delete.backgroundColor = .blue
        return [delete]
    }
    
   
}

extension ViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
      return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.users?.count ?? 0
        }else {
            return self.pets?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "data", for: indexPath) as? DataTableViewCell {
            if(indexPath.section == 0){
                cell.user = self.users?[indexPath.row]
            }else{
                cell.pet = self.pets?[indexPath.row]
            }
             return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Users"
        }else {
            return "Pets"
        }
    }
}
