//
//  User+CoreDataProperties.swift
//  KnilIT
//
//  Created by Manickam T on 24/02/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var avatar: String?
    @NSManaged public var email: String?
    @NSManaged public var firstname: String?
    @NSManaged public var id: Int64
    @NSManaged public var lastname: String?

}

extension User : Identifiable {

}
