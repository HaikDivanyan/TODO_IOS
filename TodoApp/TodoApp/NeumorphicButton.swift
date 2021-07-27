//
//  NeumorphicButton.swift
//  TodoApp
//
//  Created by Haik Divanyan on 6/11/21.
//

import SwiftUI

struct NeumorphicButton: View {
    @EnvironmentObject var todoViewModel: TodoViewModel
    var currentTodo: Todo

    var body: some View {
        Button(action: { async { await todoViewModel.deleteTodo(currentTodo) }}) {
            Text("Delete")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .frame(width: 150, height: 40)
                .background(
                    ZStack {
                    Color("lightBlue")
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundColor(.white)
                        .blur(radius: 4)
                        .offset(x: -8, y: 8)
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color("lightBlue"), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    
                        .padding(2)
                        .blur(radius: 2)
                })
            
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: Color("lightBlue"), radius: 20, x: 20, y: 20)
                .shadow(color: .white, radius: 20, x: -20, y: -20)
        }
    }
}

//struct NeumorphicButton_Previews: PreviewProvider {
//    static var previews: some View {
//        NeumorphicButton()
//    }
//}
