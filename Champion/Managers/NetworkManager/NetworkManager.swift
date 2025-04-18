import Foundation
import SwiftUI

struct UserRequest: Encodable {
    let phone: String
    let pass: String
    let metod: String
}

struct UserResponse: Decodable {
    let message: String?
    let error: String?
}

struct TaskRequest: Encodable {
    let phone: String
    let pass: String
    let metod: String
    let date: String?
    let typeactivity: String?
    let id: String?
}

struct ServerTask: Decodable {
    let id: String
    let phone: String
    let date: String
    let typeactivity: String
}

struct TaskResponse: Decodable {
    let message: String?
    let error: String?
    let task: ServerTask?
    let tasks: [ServerTask]?
}


class NetworkService {
    let host = "https://championdiary.space"
    let loginPath = "/login.php"
    
    func registerUser(phone: String, password: String, completion: @escaping (UserResponse?, Error?) -> Void) {
        let request = UserRequest(phone: phone, pass: password, metod: "registration")
        sendRequest(path: loginPath, request: request, completion: completion)
    }
    
    func loginUser(phone: String, password: String, completion: @escaping (UserResponse?, Error?) -> Void) {
        let request = UserRequest(phone: phone, pass: password, metod: "login")
        sendRequest(path: loginPath, request: request, completion: completion)
    }
    
    func deleteUser(phone: String, password: String, completion: @escaping (UserResponse?, Error?) -> Void) {
        let request = UserRequest(phone: phone, pass: password, metod: "deleteuser")
        sendRequest(path: loginPath, request: request, completion: completion)
    }
    
    func saveTask(phone: String, password: String, date: String, typeactivity: String, completion: @escaping (TaskResponse?, Error?) -> Void) {
        let request = TaskRequest(
            phone: phone,
            pass: password,
            metod: "save_task",
            date: date,
            typeactivity: typeactivity,
            id: nil
        )
        sendRequest(path: loginPath, request: request, completion: completion)
    }
    
    func getTasks(phone: String, password: String, completion: @escaping (TaskResponse?, Error?) -> Void) {
        let request = TaskRequest(
            phone: phone,
            pass: password,
            metod: "get_tasks",
            date: nil,
            typeactivity: nil,
            id: nil
        )
        sendRequest(path: loginPath, request: request, completion: completion)
    }
    
    func deleteTask(phone: String, password: String, taskId: String, completion: @escaping (TaskResponse?, Error?) -> Void) {
        let request = TaskRequest(
            phone: phone,
            pass: password,
            metod: "delete_task",
            date: nil,
            typeactivity: nil,
            id: taskId
        )
        sendRequest(path: loginPath, request: request, completion: completion)
    }
    
    private func sendRequest<T: Encodable, U: Decodable>(path: String, request: T, completion: @escaping (U?, Error?) -> Void) {
        guard let url = URL(string: "\(host)\(path)") else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            urlRequest.httpBody = try JSONEncoder().encode(request)
        } catch {
            completion(nil, error)
            return
        }
        
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
                let response = try JSONDecoder().decode(U.self, from: data)
                completion(response, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
