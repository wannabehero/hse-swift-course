import UIKit
import CoreData

class CoreDataHelper: NSObject {
    //singleton
    class var instance: CoreDataHelper {
        struct Singleton {
            static let instance = CoreDataHelper()
        }
        return Singleton.instance
    }
    
    let coordinator: NSPersistentStoreCoordinator
    let model: NSManagedObjectModel
    let context: NSManagedObjectContext
    
    private override init() {
        let modelURL = NSBundle.mainBundle()
            .URLForResource("Model",
                withExtension: "momd")!
        model = NSManagedObjectModel(
            contentsOfURL: modelURL)!
        
        let fileManager = NSFileManager.defaultManager()
        let docsURL = fileManager.URLsForDirectory(
            .DocumentDirectory, inDomains: .UserDomainMask).last as NSURL
        let storeURL = docsURL
            .URLByAppendingPathComponent("base.sqlite")
        
        coordinator = NSPersistentStoreCoordinator(
            managedObjectModel: model)
        
        let store = coordinator.addPersistentStoreWithType(
            NSSQLiteStoreType, configuration: nil,
            URL: storeURL, options: nil, error: nil)
        if store == nil {
            abort()
        }
        
        context = NSManagedObjectContext()
        context.persistentStoreCoordinator = coordinator
        super.init()
    }
    
    func save() {
        var error: NSError?
        context.save(&error)
        if let error = error {  //if error != nil
            println(error.localizedDescription)
        }
    }
    
}
