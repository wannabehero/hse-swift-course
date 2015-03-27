
import Foundation
import CoreData

@objc(Flight)
class Flight: NSManagedObject {

    @NSManaged var number: String
    @NSManaged var airline: Airline
    
    class var entity: NSEntityDescription {
        return NSEntityDescription.entityForName("Flight",
            inManagedObjectContext: CoreDataHelper.instance.context)!
    }

    convenience init() {
        self.init(entity: Flight.entity,
            insertIntoManagedObjectContext: CoreDataHelper.instance.context)
    }
    
    class func allFlights() -> [Flight] {
        let request = NSFetchRequest(entityName: "Flight")
        
        var results = CoreDataHelper.instance.context.executeFetchRequest(request, error: nil)
        
        return results as [Flight]
    }
}



