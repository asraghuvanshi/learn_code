//
//  Users+CoreDataProperties.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 02/02/2024.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var fullName: String?
    @NSManaged public var userEmail: String?
    @NSManaged public var profileImageUrl: Data?
    @NSManaged public var userId: String?

}

extension Users : Identifiable {

}
