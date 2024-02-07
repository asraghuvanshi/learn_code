//
//  PersistenceStorage.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 02/02/2024.
//

import Foundation
import CoreData
import UIKit


protocol UserContextManager {
    func saveUserData(user: UserResponse)
    func getAllUser() -> [Users]
    func updateUser() -> Bool
    func deleteAllUser() -> Bool
}

struct DataModel : UserContextManager {

    ///   Save User Details in Core Data Model
    func saveUserData(user: UserResponse) {
        let userObj = Users(context: PersistenceStorage.shared.context)
        userObj.userId = user.userId
        userObj.fullName = user.fullName
        userObj.userEmail = user.userEmail

        PersistenceStorage.shared.saveContext()
    }
    
    ///   Fetch all users from Core Data
    func getAllUser() -> [Users] {
        var userDataArray = Array<Users>()
        let context = PersistenceStorage.shared.context
        
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
       
        /// get path 
        if let applicationSupportDir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
            let databaseURL = applicationSupportDir.appendingPathComponent("Users.sqlite")
            print("Database URL: \(databaseURL)")
        }
        
        do {
            let users = try context.fetch(fetchRequest)
            print("Fetched \(users.count) users successfully.")
            return users
        } catch {
            print("Error fetching users: \(error)")
            return []
        }
    }
    
    ///  Update User Data in Core Data Model
    func updateUser() -> Bool {
        //        let userObject =
        return true
    }
    
    ///  Delete User from Core Data Model
    func deleteAllUser() -> Bool {
        let context = PersistenceStorage.shared.context
     
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Users.fetchRequest()
           let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

           do {
               try context.execute(batchDeleteRequest)
               try context.save()
               print("All user data deleted successfully.")
           } catch {
               print("Error deleting user data: \(error)")
           }
        return true
    }
}

final class PersistenceStorage {
    // MARK: - Core Data stack
    
    private init() {
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
        if let applicationSupportDir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
            let databaseURL = applicationSupportDir.appendingPathComponent("Users.sqlite")
            print("Database URL: \(databaseURL)")
        }
        if context.hasChanges {
            do {
                try context.save()
                print("Data has been saved")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchManagedObject<Template: NSManagedObject>(managedObject: Template.Type) -> [Template]? {
        
        do {
            guard let result = try PersistenceStorage.shared.context.fetch(managedObject.fetchRequest()) as? [Template] else {
                return nil
            }
        } catch let error {
            print(error)
        }
        return nil
    }
    
    func userDataExistsInCoreData(_ userData: UserResponse) -> Bool {
        
        let persistentContainer = PersistenceStorage.shared.persistentContainer
     
        guard let userEmail = userData.userEmail else{
            return false
        }
        let fetchRequest = NSFetchRequest<Users>(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "userEmail == %@", userEmail)
        
        do {
            let results = try PersistenceStorage.shared.context.fetch(fetchRequest)
            return results.count > 0
        } catch {
            print("Error checking if data exists in Core Data: \(error)")
            return false
        }
    }
    
}


struct UserManager : UserContextManager{

    private let _manager = DataModel()
    
    
    func saveUserData(user: UserResponse) {
        _manager.saveUserData(user: user)
    }
    
    func getAllUser() -> [Users] {
        return _manager.getAllUser()
    }
    
    func updateUser() -> Bool {
        return true
    }
    
    func deleteAllUser() -> Bool {
        _manager.deleteAllUser()
        return true
    }
}
