//
//  TodoApiViewModel.swift
//  TodoApp
//
//  Created by Haik Divanyan on 6/10/21.
//

import Foundation

class TodoViewModel: ObservableObject {
    
    // load all Todos
    //    init() async { await getTodos() }
    
    private var api = WebService()
    
    @Published var addButtonIsPressed: Bool = false
    
    // array that holds all Todo items
    @Published var todos = [Todo]()
    
    // updates self.todos
    @MainActor
    func getTodos(filterCompleted: Bool = false) async {
        do {
            self.todos = try await api.fetchAll()
            if filterCompleted {
                self.todos = self.todos.filter { todo in
                    !todo.isCompleted
                }
            }
        }
        catch {
            print("unable to get Todos...")
        }
    }
    
    @MainActor
    func makeTodo(name: String) async {
        do {
            try await api.create(name: name)
            await getTodos()
        }
        catch {
            print("unable to create Todo...")
        }
    }
    
    @MainActor
    func toggleTodo(_ todo: Todo) async {
        do {
            try await api.update(todo)
            await getTodos()
        }
        catch {
            print("unable to update...")
        }
    }
    
    @MainActor
    func deleteTodo(_ todo: Todo) async {
        do {
            try await api.delete(todo: todo)
            await getTodos()
        }
        catch {
            print("unable to delete...")
        }
    }
}

