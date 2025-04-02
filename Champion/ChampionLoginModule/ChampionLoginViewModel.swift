import SwiftUI

class ChampionLoginViewModel: ObservableObject {
    let contact = ChampionLoginModel()
    @Published var phone = ""
    @Published var password = ""
    @Published var showErrorAlert = false
    @Published var alertMessage = ""
    @Published var isTab = false
    @Published var isOnb = false

    func login(completion: @escaping (Bool) -> Void) {
        guard !phone.isEmpty else {
            alertMessage = "Please enter phone number"
            showErrorAlert = true
            completion(false)
            return
        }
        
        guard !password.isEmpty else {
            alertMessage = "Please enter password"
            showErrorAlert = true
            completion(false)
            return
        }
        
        NetworkService().loginUser(phone: phone, password: password) { [weak self] response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.alertMessage = "Erorr: \(error.localizedDescription)"
                    self?.showErrorAlert = true
                }
                completion(false)
                return
            }
            
            if let response = response {
                if let message = response.message {
                    if message == "Авторизация успешна" {
                        completion(true)
                    } else {
                        completion(true)
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
