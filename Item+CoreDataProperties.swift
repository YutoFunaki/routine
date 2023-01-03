//
//  Item+CoreDataProperties.swift
//  routine
//
//  Created by 船木勇斗 on 2023/01/03.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var title: String?

}

extension Item : Identifiable {

}
