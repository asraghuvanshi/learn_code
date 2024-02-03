//
//  PersistenceStorage.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 02/02/2024.
//

import Foundation
import CoreData


protocol UserContextManager {
    func saveUser(user: Users)
    func getAllUser() -> [Users]
    func updateUser() -> Bool
}

struct UserDataModel : UserContextManager {
    
   ///   Save User Details in Core Data Model
    func saveUser(user: Users) {
        let userObj = Users(context: PersistenceStorage.shared.context)
        userObj.userId = user.userId
        userObj.fullName = user.fullName
        userObj.userEmail = user.userEmail
        userObj.profileImageUrl = user.profileImageUrl
       
        PersistenceStorage.shared.saveContext()
    }
    
    ///   Fetch all users from Core Data
    func getAllUser() -> [Users] {
        var userDataArray = Array<Users>()
        do {
            let userData = try PersistenceStorage.shared.context.fetch(Users.fetchRequest())
            return userData
            
        } catch let error {
            print(error)
            return []
        }
    }
    
    ///  Update User Data in Core Data Model
    func updateUser() -> Bool {
//        let userObject =
        return true
    }
    
    ///  Delete User from Core Data Model
    func deleteUser(user: String) -> Bool {
        
        return true
    }
}

final class PersistenceStorage {
    // MARK: - Core Data stack
    
    private init() {
       print("this is private init")
    }
    
    static var shared = PersistenceStorage()
    
    lazy var persistentContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "Users")
       container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
             fatalError("Unresolved error \(error), \(error.userInfo)")
          }
       })
       return container
    }()
    
    // MARK: - Core Data Saving support
    
    lazy var context = persistentContainer.viewContext
    
    func saveContext () {
      
       if context.hasChanges {
          do {
             try context.save()
          } catch {
             let nserror = error as NSError
             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
       }
    }
}
