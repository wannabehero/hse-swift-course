
import Foundation
import CoreData

@objc(Airline)
class Airline: NSManagedObject {
    
    @NSManaged var code: String
    @NSManaged var name: String
    @NSManaged var flights: NSSet

    class var entity: NSEntityDescription {
        return NSEntityDescription.entityForName("Airline",
            inManagedObjectContext: CoreDataHelper.instance.context)!
    }
    
    convenience init() {
        self.init(entity: Airline.entity,
            insertIntoManagedObjectContext: CoreDataHelper.instance.context) //nil если не храним
    }
    
    convenience init(code: String, name: String) {
        self.init()
        self.code = code
        self.name = name
    }
    
    class func allAirlines() -> [Airline] {
        let request = NSFetchRequest(entityName: "Airline")
        
        //сортировка по возрастанию по полю name
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        var results = CoreDataHelper.instance.context.executeFetchRequest(request, error: nil)
        
        return results as! [Airline]
    }
}
