//
//  CustomProgressView.swift
//  SwiftUI_Modifiers
//
//  Created by Daniel Manrique Figueroa on 1/30/21.
//

import SwiftUI

struct ProgressViewModifier : ViewModifier {
    @Binding var isShowing : Bool
    
    var text : String
    var size : CGSize
    var color : Color
    
    func body(content: Content) -> some View {
    
        ZStack { content

            if isShowing {
                withAnimation {
                    showProgressView()
                }
            }
        }
    }
}

extension ProgressViewModifier {
    
    private func showProgressView() -> some View {
        VStack (spacing : 20) {
            
            CustomProgressView(color: self.color,
              isRunning: self.$isShowing)

            Text(text)
                .foregroundColor(.black)
                .font(.headline)
        }
        .frame(width: size.width, height: size.height)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 20 )
    }
}

struct CustomProgressView: View {
    var color : Color
    
    @Binding var isRunning : Bool
    @State private var position : Int = 0
    
    var body: some View {
        HStack (spacing: 10){
            Circle()
            .fill( (self.position == 0) ? self.color : Color(UIColor.lightGray) )
            .frame(width: 30, height: 30)
            
            Circle()
            .fill( (self.position == 1) ? self.color : Color(UIColor.lightGray)  )
            .frame(width: 30, height: 30)
            
            Circle()
            .fill( (self.position == 2) ? self.color : Color(UIColor.lightGray)  )
            .frame(width: 30, height: 30)
        }
        .onAppear{
             Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                withAnimation{
                    self.changePosition()
                }
                
                if !self.isRunning {
                    timer.invalidate()
                }
             }
        }
    }
}

struct CustomProgressViewUI : View {
    @State private var showProgressView : Bool = false

    var body: some View {
        
        Button(action: {
 
            self.showProgressView = true
            // close it after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                self.showProgressView = false
            }
            
        }, label: {
            Text("Tap To Load")
        }) // the custom modifier progressView
        .progressView(isShowing: self.$showProgressView)
    }
}

extension View {
    func progressView(isShowing: Binding <Bool>,text : String = "Loading...", size : CGSize =
    CGSize(width:160, height:160), color : Color = .purple) -> some View{
        self.modifier(ProgressViewModifier(isShowing: isShowing, text: text, size: size, color: color))
    }
}

extension CustomProgressView  {
    private func changePosition(){
        if self.position < 3 {
            self.position += 1
            if ( self.position == 3 )
            {
                self.position = 0
            }
        }
    }
}

struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressViewUI()
    }
}
