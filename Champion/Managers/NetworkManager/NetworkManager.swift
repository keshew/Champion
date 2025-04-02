struct UserRequest: Encodable {
    let phone: String
    let pass: String
    let metod: String
}

struct UserResponse: Decodable {
    let message: String?
    let error: String?
}

import Foundation

class NetworkService {
    let host = "https://championdiary.space"
    let path = "/login.php"
    
    func registerUser(phone: String, password: String, completion: @escaping (UserResponse?, Error?) -> Void) {
        let request = UserRequest(phone: phone, pass: password, metod: "registration")
        sendRequest(request: request, completion: completion)
    }
    
    func loginUser(phone: String, password: String, completion: @escaping (UserResponse?, Error?) -> Void) {
        let request = UserRequest(phone: phone, pass: password, metod: "login")
        sendRequest(request: request, completion: completion)
    }
    
    func deleteUser(phone: String, password: String, completion: @escaping (UserResponse?, Error?) -> Void) {
        let request = UserRequest(phone: phone, pass: password, metod: "deleteuser")
        sendRequest(request: request, completion: completion)
    }
    
    private func sendRequest(request: UserRequest, completion: @escaping (UserResponse?, Error?) -> Void) {
        guard let url = URL(string: "\(host)\(path)") else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try? JSONEncoder().encode(request)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data", code: 0, userInfo: nil))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(UserResponse.self, from: data)
                completion(response, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
