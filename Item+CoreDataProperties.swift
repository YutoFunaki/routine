//
//  Item+CoreDataProperties.swift
//  routine
//
//  Created by čšć¨ĺć on 2023/01/03.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var title: String?
    @NSManaged public var finishHour: NSNumber?
    @NSManaged public var startHour: NSNumber?
    @NSManaged public var weekDay: NSNumber?
    @NSManaged public var startMin: NSNumber?
    @NSManaged public var finishMin: NSNumber?
    @NSManaged public var id: UUID?
    
    

}

extension Item : Identifiable {
    
    //public var stringStartTime: String { dateFomatter(date: startTime ?? Date()) }
    //public var stringFinishTime: String { dateFomatter(date: finishTime ?? Date()) }
    //public var stringWeekDay: String { dateFomatter(date: (weekDay ?? NSNumber()) ) }
    
    func dateFomatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        
        return dateFormatter.string(from: date)
    }
}
