//
//  model.swift
//  TodoApp
//
//  Created by Haik Divanyan on 6/10/21.
//

import Foundation

struct Todo: Identifiable, Codable {
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "_id"
        case isCompleted = "status"
    }
    
    var id: String
    var name: String
    var isCompleted: Bool
    
}

struct TodoEncodable: Encodable {
    var name: String
}

class WebService {
    
    let Url: String = "http://localhost:3000/"
    
    enum WebErrors: Error {
        case invalidURL, WebPostError
    }

    func fetchAll() async throws -> [Todo] {
        
        
        guard let url = URL(string: Url + "get-tasks") else { throw WebErrors.invalidURL }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (result, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([Todo].self, from: result)
    }
    
    func create(name: String) async throws {
        guard let url = URL(string: Url + "create" ) else { return }
        let todoToAdd = TodoEncodable(name: name)
        
        guard let encodedData = try? JSONEncoder().encode(todoToAdd) else {
            print("failed to encode data")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encodedData
        
        let (_, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw WebErrors.WebPostError }
    }
    
    func update(_ todo: Todo) async throws {
        

        guard let url = URL(string: Url + "update-task/" + todo.id) else { return }
        var request = URLRequest(url: url)
        
        let todoToUpdate = Todo(id: todo.id, name: todo.name, isCompleted: !todo.isCompleted)
        guard let encodedData = try? JSONEncoder().encode(todoToUpdate) else {
            print("failed to encode data...")
            return
        }
        
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

//        let body: [String: String] = ["name": todo.name, "status": "\(!todo.isCompleted)"]
//        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        request.httpBody = encodedData

    
        
        let (_, response) = try await URLSession.shared.data(for: request)
        //print((response as? HTTPURLResponse)?.statusCode)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw WebErrors.WebPostError }
        
        
    }
    
    func delete(todo: Todo) async throws {
        guard let url = URL(string: Url + "delete-task/" + todo.id) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (_, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw WebErrors.WebPostError }
        print("todo deleted")
    }

}



