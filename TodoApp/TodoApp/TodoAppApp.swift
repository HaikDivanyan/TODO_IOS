//
//  TodoAppApp.swift
//  TodoApp
//
//  Created by Haik Divanyan on 6/10/21.
//

import SwiftUI

@main
struct TodoAppApp: App {
    @StateObject var todoViewModel = TodoViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(todoViewModel)
        }
    }
}
