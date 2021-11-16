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
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentCloudKitContainer(name: "WabiSabiTeamProject")
        let description = container.persistentStoreDescriptions.first
         
         // Load both stores
        description?.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.id.infinitelearning.wabisabi")

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
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
    
    func setProduct(brand: String, expiredDate: Date, name: String, periodAfterOpening: Date, picture: String) {
        let product = Product(context: persistentContainer.viewContext)
        product.brand = brand
        product.expiredDate = expiredDate
        product.name = name
        product.periodAfterOpening = periodAfterOpening
        product.picture = picture
        save()
    }
    
    func setReminder(reminderTime: String) {
        let reminder = Reminder(context: persistentContainer.viewContext)
        reminder.reminderTime = reminderTime
        save()
    }
    
    func setRoutine(isEveryday: Bool, name: String, startHabit: Date) {
        let routines = Routines(context: persistentContainer.viewContext)
        routines.isEveryday = isEveryday
        routines.name = name
        routines.startHabit = startHabit
        save()
    }
    
    func setSchedule(time: String) {
        let schedule = Schedule(context: persistentContainer.viewContext)
        schedule.schedule = time
        save()
    }
    
    func setType(isSelected: Bool, name: String) {
        let type = Type(context: persistentContainer.viewContext)
        type.isSelected = isSelected
        type.name = name
        save()
    }
    
    func setUser(dateOfBirth: Date, gender: String, isNotify: Bool, level: String, localization: String, name: String, skinType: String) {
        let user = User(context: persistentContainer.viewContext)
        user.dateOfBirth = dateOfBirth
        user.gender = gender
        user.isNotify = isNotify
        user.level = level
        user.localization = localization
        user.name = name
        user.skinType = skinType
        save()
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
        
        var product: [Product] = []
        
        do {
            product = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching authors")
        }
        
        return product
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
    
    func fetchType() -> [Type] {
        let request: NSFetchRequest<Type> = Type.fetchRequest()
        
        var type: [Type] = []
        
        do {
            type = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching authors")
        }
        
        return type
    }
    
    func fetchUser() -> [User] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        var user: [User] = []
        
        do {
            user = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching authors")
        }
        
        return user
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
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
