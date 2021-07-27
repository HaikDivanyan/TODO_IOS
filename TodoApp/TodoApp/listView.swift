//
//  listView.swift
//  TodoApp
//
//  Created by Haik Divanyan on 6/12/21.
//

import SwiftUI

var names: [String] = ["Cat", "Hannah", "Mike", "Joe"]


struct listView: View {
    var body: some View {
        GeometryReader { proxy in
            NavigationView {
                VStack(alignment: .center, spacing: 10) {
                    
                    Spacer()
                    
                    ForEach(names, id: \.self) { name in
                        HStack {
                            Button(action: {}) {
                                Image(systemName: "circle")
                            }
                            Text("\(name)")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                            Spacer()
                        }.padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    
//                    RoundedRectangle(cornerRadius: 25)
//                        .fill(rectangleColor)
//                        .frame(width: 317, height: 276)
//                        .shadow(color: shadowColor, radius:14, x:0, y:1)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationTitle("Todo")
                .background(backgroundColor).ignoresSafeArea()
                
            }
        }
    }
}







let backgroundColor = LinearGradient(
    gradient: Gradient(stops: [
.init(color: Color(#colorLiteral(red: 0.13333334028720856, green: 0.20392157137393951, blue: 0.23529411852359772, alpha: 1)), location: 0.0007918074261397123),
.init(color: Color(#colorLiteral(red: 0.12156862765550613, green: 0.18039216101169586, blue: 0.2078431397676468, alpha: 1)), location: 1)]),
    startPoint: UnitPoint(x: -0.08938116066092056, y: 0.56955788402664),
    endPoint: UnitPoint(x: 0.6099469288521624, y: 1.3496640680055174))

let rectangleColor = Color(#colorLiteral(red: 0.1882352977991104, green: 0.2666666805744171, blue: 0.30588236451148987, alpha: 1))

let shadowColor = Color(#colorLiteral(red: 0.09803921729326248, green: 0.1568627506494522, blue: 0.18431372940540314, alpha: 1))

struct listView_Previews: PreviewProvider {
    static var previews: some View {
        listView()
            .preferredColorScheme(.dark)
    }
}
