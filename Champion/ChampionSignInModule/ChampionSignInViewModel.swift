import SwiftUI

class ChampionSignInViewModel: ObservableObject {
    let contact = ChampionSignInModel()
    @Published var phone = ""
    @Published var password = ""
    @Published var showErrorAlert = false
    @Published var alertMessage = ""
    @Published var isLog = false
    @Published var isTab = false
    @Published var isOnb = false
    @Published var isNew = false
    
    func register() -> Bool {
        guard !phone.isEmpty else {
            alertMessage = "Please enter phone number"
            showErrorAlert = true
            return false
        }
        
        guard !password.isEmpty else {
            alertMessage = "Please enter password"
            showErrorAlert = true
            return false
        }
        
        NetworkService().registerUser(phone: phone, password: password) { [weak self] response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.alertMessage = "Erorr: \(error.localizedDescription)"
                    self?.showErrorAlert = true
                }
                return
            }
            
            if let response = response {
                if let _ = response.message {
                    if let error = response.error {
                        DispatchQueue.main.async {
                            self?.alertMessage = "Error: \(error)"
                            self?.showErrorAlert = true
                        }
                    }
                }
            }
        }
        return true
    }
}
