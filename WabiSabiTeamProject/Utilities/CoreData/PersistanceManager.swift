//
//  PersistanceManager.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 12/11/21.
//

import Foundation
import CoreData

class PersistanceManager {
    static let shared = PersistanceManager()
    
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        
        let container = NSPersistentCloudKitContainer(name: "WabiSabiTeamProject")
        let description = container.persistentStoreDescriptions.first
         
         // Load both stores
        description?.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.com.id.infinitelearning.wabisabi")

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        // MARK: DEBUG
        // Only initialize the schema when building the app with the
        // Debug build configuration.
//        #if DEBUG
//        do {
//            // Use the container to initialize the development schema.
//            try container.initializeCloudKitSchema(options: [])
//        } catch {
//            // Handle any errors.
//        }
//        #endif
        
        
        
        return container
    }()
    
    var context: NSManagedObjectContext {
        let context = PersistanceManager.shared.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }
    
    func setLocation(lang: String, long: String, name: String) {
        let location = Location(context: persistentContainer.viewContext)
        location.name = name
        location.lang = lang
        location.long = long
        save()
    }
    
    func setProduct(brand: String, expiredDate: Date, name: String, periodAfterOpening: Date, picture: String, routine: Routines, productType: String) {
        let product = Product(context: persistentContainer.viewContext)
        product.id = "\(UUID())"
        product.brand = brand
        product.expiredDate = expiredDate
        product.name = name
        product.periodAfterOpening = periodAfterOpening
        product.picture = picture
        product.routineproduct = routine
        product.productType = productType
        save()
        print ("DATA SAVED")
    }
    
    func updateProduct(id: String, name: String, brand: String, periodAfterOpening: Date, picture: String, routine: Routines, expiredDate: Date, productType : String){
            // 1. fetch data
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
            
            // 2. set predicate (condition)
            fetchRequest.predicate = NSPredicate(format: "id = %@", id)
            
            // 3. execute update
            do {
                let objects = try context.fetch(fetchRequest)
                let objectToBeUpdated = objects[0] as!NSManagedObject
                objectToBeUpdated.setValue(brand, forKey: "brand")
                objectToBeUpdated.setValue(expiredDate, forKey: "expiredDate")
                objectToBeUpdated.setValue(name, forKey: "name")
                objectToBeUpdated.setValue(periodAfterOpening, forKey: "periodAfterOpening")
                objectToBeUpdated.setValue(picture, forKey: "picture")
                objectToBeUpdated.setValue(productType, forKey: "productType")
            } catch {
                // do something if error
            }
            
            // 4. save
            do {
                try
                context.save()
            } catch let error as NSError {
                // do something if error...
            }
            
//            // 5. reload data
            fetchProduct(routine: routine)
        }
    
    
    func setProduct(name: String) {
        let product = Product(context: persistentContainer.viewContext)
        product.id = "\(UUID())"
        product.name = name
        product.routineproduct = fetchRoutine(id: UserDefaults.standard.string(forKey: "routineID")!)
        product.userproduct = fetchUser()
        save()
    }
    
    func setReminder(reminderTime: String) {
        let reminder = Reminder(context: persistentContainer.viewContext)
        reminder.reminderTime = reminderTime
        save()
    }
    
    func setRoutine(isEveryday: Bool, name: String, startHabit: Date) {
        let routine = Routines(context: persistentContainer.viewContext)
        routine.id = "\(UUID())"
        routine.isEveryday = isEveryday
        routine.name = name
        routine.startHabit = startHabit
        routine.userroutine = fetchUser()
        save()
        
        if let routineID = routine.id {
            UserDefaults.standard.set(routineID, forKey: "routineID")
            print("Routine ID \(routineID) has been saved")
        }
    }
    
    func setRoutine(isEveryday: Bool, name: String) {
        let routine = Routines(context: persistentContainer.viewContext)
        routine.id = "\(UUID())"
        routine.isEveryday = isEveryday
        routine.name = name
        routine.userroutine = fetchUser()
        save()
        
        if let routineID = routine.id {
            UserDefaults.standard.set(routineID, forKey: "routineID")
            print("Routine ID \(routineID) has been saved")
        }
    }
    
    func setSchedule(time: String) {
        let schedule = Schedule(context: persistentContainer.viewContext)
        schedule.schedule = time
        save()
    }
    
//    func setType(isSelected: Bool, name: String) {
//        let type = ProductType(context: persistentContainer.viewContext)
//        type.isSelected = isSelected
//        type.name = name
//        save()
//    }
    
    func setUser(dateOfBirth: Date, gender: String, isNotify: Bool, level: String, localization: String, name: String, skinType: String) {
        let user = User(context: persistentContainer.viewContext)
        user.id = "\(UUID())"
        user.dateOfBirth = dateOfBirth
        user.gender = gender
        user.isNotify = isNotify
        user.level = level
        user.localization = localization
        user.name = name
        user.skinType = skinType
        save()
        
        if let userID = user.id {
            UserDefaults.standard.set(userID, forKey: "userID")
            print("User ID \(userID) has been saved")
        }
    }
    
    func fetchCategory() -> [Category] {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        var category: [Category] = []
        
        do {
            category = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching authors")
        }
        
        return category
    }
    
    func fetchLocation() -> [Location] {
        let request: NSFetchRequest<Location> = Location.fetchRequest()
        
        var location: [Location] = []
        
        do {
            location = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching authors")
        }
        
        return location
    }
    
    func fetchProduct() -> [Product] {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        
        var products: [Product] = []
        
        do {
            products = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching authors")
        }
        
        return products
    }
    
    func fetchProduct(routine: Routines) -> [Product] {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        request.predicate = NSPredicate(format: "routineproduct = %@", routine)
        
        var products: [Product] = []
        
        do {
            products = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching authors")
        }
        
        return products
    }
    
    func fetchReminder() -> [Reminder] {
        let request: NSFetchRequest<Reminder> = Reminder.fetchRequest()
        
        var reminder: [Reminder] = []
        
        do {
            reminder = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching authors")
        }
        
        return reminder
    }
    
    func fetchRoutines() -> [Routines] {
        let request: NSFetchRequest<Routines> = Routines.fetchRequest()
        
        var routines: [Routines] = []
        
        do {
            routines = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching authors")
        }
        
        return routines
    }
    
    func fetchRoutine(id: String) -> Routines {
        let request: NSFetchRequest<Routines> = Routines.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id as! CVarArg)
        
        var routines: [Routines] = []
        
        do {
            routines = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching authors")
        }
        
        return routines[0]
    }
    
    func fetchSchedule() -> [Schedule] {
        let request: NSFetchRequest<Schedule> = Schedule.fetchRequest()
        
        var schedule: [Schedule] = []
        
        do {
            schedule = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching authors")
        }
        
        return schedule
    }
    
    func fetchSubcategory() -> [Subcategory] {
        let request: NSFetchRequest<Subcategory> = Subcategory.fetchRequest()
        
        var subcategory: [Subcategory] = []
        
        do {
            subcategory = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching authors")
        }
        
        return subcategory
    }
    
//    func fetchType() -> [ProductType] {
//        let request: NSFetchRequest<ProductType> = ProductType.fetchRequest()
//        
//        var productType: [ProductType] = []
//        
//        do {
//            productType = try persistentContainer.viewContext.fetch(request)
//        } catch {
//            print("Error fetching product type")
//        }
//        
//        return productType
//    }
    
    func fetchUser() -> User {
        var userID = UserDefaults.standard.string(forKey: "userID")
        
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", userID as! CVarArg)
        
        var user: [User] = []
        
        do {
            user = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching authors")
        }
        
        if user.count > 0 {
            return user[0]
        }
        
        return User()
    }
    
    func deleteLocation(location : Location) {
        persistentContainer.viewContext.delete(location)
        save()
    }
    
    func deleteProduct(product : Product) {
        persistentContainer.viewContext.delete(product)
        save()
    }
    
    func deleteReminder(reminder : Reminder) {
        persistentContainer.viewContext.delete(reminder)
        save()
    }
    
    func deleteRoutines(routines : Routines) {
        persistentContainer.viewContext.delete(routines)
        save()
    }
    
    func deleteSchedule(schedule : Schedule) {
        persistentContainer.viewContext.delete(schedule)
        save()
    }
    
    func deleteUser(user : User) {
        persistentContainer.viewContext.delete(user)
        save()
    }
    
    /*
    func fetchBook(author: Author) -> [Book] {
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        
        request.predicate = NSPredicate(format: "(author = %@)", author)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        var books: [Book] = []
        
        do{
            books = try persistentContainer.viewContext.fetch(request)
        }
        catch {
            print("Error fetching books data")
        }
        return books
    }
    */
    
    func save () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
