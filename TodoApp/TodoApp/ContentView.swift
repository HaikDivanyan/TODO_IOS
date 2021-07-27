//
//  ContentView.swift
//  TodoApp
//
//  Created by Haik Divanyan on 6/10/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var todoViewModel: TodoViewModel
    var body: some View {
        NavigationView {
            ZStack {
                Color("bg").ignoresSafeArea()
                
                List(todoViewModel.todos) { todo in
                    HStack {
                        Button(
                            action: {
                            async { await todoViewModel.toggleTodo(todo) }
                        }) {
                            Image(systemName: (!todo.isCompleted ? "circle" : "circle.fill"))
                        }
                        Text("\(todo.name)")
                        Spacer()
                        NeumorphicButton(currentTodo: todo)
                    }
                    
                }
                .listRowBackground(Color("bg"))
            }
            .navigationBarItems(
                trailing: Button(action: {
                todoViewModel.addButtonIsPressed.toggle()
            }) {
                Image(systemName: "plus")
            })
            .navigationTitle("TODO")
            .refreshable {
                await todoViewModel.getTodos()
            }
            .onAppear {
                async { await todoViewModel.getTodos() }
            }
            .sheet(isPresented: $todoViewModel.addButtonIsPressed) {
                AddButtonView()
                
            }
        }
    }
}
    


struct AddButtonView: View {
    @EnvironmentObject var todoViewModel: TodoViewModel
    @State var newTaskName: String = ""
    var body: some View {
        VStack {
            TextField("Name of the new task", text: $newTaskName)
            Button(action: {
                async {
                    await todoViewModel.makeTodo(name: newTaskName)
                    todoViewModel.addButtonIsPressed = false
                }
            }) {
                Text("Done")
            }
        }

    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environmentObject(TodoViewModel())
        }
    }
}
