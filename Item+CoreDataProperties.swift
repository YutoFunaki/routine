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
    @NSManaged public var finishTime: Date?
    @NSManaged public var startTime: Date?

}

extension Item : Identifiable {
    
    public var stringStartTime: String { dateFomatter(date: startTime ?? Date()) }
    public var stringFinishTime: String { dateFomatter(date: finishTime ?? Date()) }
    
    func dateFomatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        
        return dateFormatter.string(from: date)
    }
}
