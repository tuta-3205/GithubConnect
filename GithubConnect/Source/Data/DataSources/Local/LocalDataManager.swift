import UIKit
import Foundation
import CoreData

final class LocalDataManager {
    
    static let shared = LocalDataManager()
    private var appDelegate: AppDelegate?
    
    private init() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
    }
    
    func saveProfile(_ profile: ProfileUserModel) {
        guard let appDelegate = appDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "ProfileEntity", in: managedContext)!
        
        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        user.setValue(profile.login, forKey: "login")
        user.setValue(profile.avatarURL, forKey: "avatar_url")
        user.setValue(profile.htmlURL, forKey: "html_url")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteProfile(_ profile: ProfileUserModel) {
        guard let appDelegate = appDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ProfileEntity")
        fetchRequest.includesPropertyValues = false
        do {
            let items = try managedContext.fetch(fetchRequest)
            for item in items {
                if (item.value(forKey: "login") as? String == (profile.login ?? "")) {
                    managedContext.delete(item)
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func isProfileInData(_ login: String) -> Bool{
        guard let appDelegate = appDelegate else { return false }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ProfileEntity")
        fetchRequest.includesPropertyValues = false
        do {
            let items = try managedContext.fetch(fetchRequest)
            for item in items {
                if (item.value(forKey: "login") as? String == login) {
                    return true
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return false
    }
    
    func getFavoriteUserList(completion: @escaping ([NSManagedObject], Error?) -> (Void)) {
        guard let appDelegate = appDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ProfileEntity")
        fetchRequest.includesPropertyValues = false
        do {
            let items = try managedContext.fetch(fetchRequest)
            completion(items, nil)
        } catch let error as NSError {
            DispatchQueue.main.async {
                completion([], error)
            }
            return
        }
    }
}
