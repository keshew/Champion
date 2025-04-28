import Foundation
import SwiftUI

class UserDefaultsManager: ObservableObject {
    func isFirstLaunch() -> Bool {
        let defaults = UserDefaults.standard
        let isFirstLaunch = defaults.bool(forKey: "isFirstLaunch")
        
        if !isFirstLaunch {
            defaults.set(true, forKey: "isFirstLaunch")
            return true
        }
        
        return false
    }
    
    func saveTasks(_ tasks: [TaskModel]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tasks) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "tasks")
        }
    }
    
    func loadTasks() -> [TaskModel]? {
        let decoder = JSONDecoder()
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: "tasks") {
            return try? decoder.decode([TaskModel].self, from: data)
        }
        return nil
    }
    
    func appendTask(_ task: TaskModel) {
        if var existingTasks = loadTasks() {
            existingTasks.append(task)
            saveTasks(existingTasks)
        } else {
            saveTasks([task])
        }
    }
    
    func deleteAllTasks() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "tasks")
    }
    
    func checkLogin() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "isLoggedIn")
    }
    
    func saveLoginStatus(_ isLoggedIn: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(isLoggedIn, forKey: "isLoggedIn")
    }
    
    func getEmail() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "currentEmail")
    }

    func getPassword() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "password")
    }
    
    func logout() {
        saveLoginStatus(false)
    }
    
    func saveCurrentEmail(_ email: String) {
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "currentEmail")
    }
    
    func savePassword(_ password: String) {
        let defaults = UserDefaults.standard
        defaults.set(password, forKey: "password")
    }
    
    func deletePassword() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "password")
    }

    func deletePhone() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "currentEmail")
    }
}
