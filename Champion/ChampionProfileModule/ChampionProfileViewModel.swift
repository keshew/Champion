import SwiftUI

class ChampionProfileViewModel: ObservableObject {
    let contact = ChampionProfileModel()
    @Published var showErrorAlert = false
    @Published var alertMessage = ""
    @Published var isOut = false
    @Published var isTog: Bool {
        didSet {
            UserDefaults.standard.set(isTog, forKey: "isTog")
            
            if !isTog {
                NotificationManager.shared.cancelAllNotifications()
            }
        }
    }

    init() {
        self.isTog = UserDefaults.standard.bool(forKey: "isTog")
    }
    
    func deleteUser(completion: @escaping (Bool) -> Void) {
        guard let email = UserDefaultsManager().getEmail(),
              let password = UserDefaultsManager().getPassword() else {
            completion(false)
            DispatchQueue.main.async {
                self.alertMessage = "Something went wrong"
                self.showErrorAlert = true
            }
            return
        }
        
        NetworkService().deleteUser(phone: email, password: password) { [weak self] response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.alertMessage = "Error: \(error.localizedDescription)"
                    self?.showErrorAlert = true
                }
                completion(false)
                return
            }
            
            if let response = response {
                if let message = response.message {
                    if message == "Пользователь удален" {
                        UserDefaultsManager().saveLoginStatus(false)
                        UserDefaultsManager().deletePhone()
                        UserDefaultsManager().deletePassword()
                        UserDefaultsManager().deleteAllTasks()
                        completion(true)
                        DispatchQueue.main.async {
                            self?.isOut = true
                        }
                    } else {
                        UserDefaultsManager().saveLoginStatus(false)
                        UserDefaultsManager().deletePhone()
                        UserDefaultsManager().deletePassword()
                        UserDefaultsManager().deleteAllTasks()
                        completion(true)
                        DispatchQueue.main.async {
                            self?.isOut = true
                        }
                    }
                } else if let error = response.error {
                    DispatchQueue.main.async {
                        self?.alertMessage = "Error: \(error)"
                        self?.showErrorAlert = true
                    }
                    completion(false)
                }
            }
        }
    }


}
