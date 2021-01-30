//
//  ContentView.swift
//  SwiftUI_Modifiers
//
//  Created by Daniel Manrique Figueroa on 1/30/21.
//

import SwiftUI

struct ShadowedRoundCorner : ViewModifier {
    func body(content : Content) -> some View{
        content
        .padding()
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 20 )
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world modifiers in SwiftUI !")
            .foregroundColor(.black)
            .roundIt()
            //.modifier(ShadowedRoundCorner())
    }
}

extension View {
    func roundIt() -> some View {
       self.modifier(ShadowedRoundCorner())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


