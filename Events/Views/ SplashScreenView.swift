//
//   SplashScreenView.swift
//  Events
//
//  Created by Norah Alfari on 17/06/1445 AH.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive = false
    @State private var size = 0.4
   
    
    var body: some View {
        ZStack{
            
            if isActive{
                OnboardingView()
            }else {
                Color("mygreen")
                    .ignoresSafeArea()
          
                VStack{
                    VStack{
                        Text("EventHub")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).accentColor(.black)
                            //.foregroundStyle(Color.darkBlue)
                            .padding(32)
                      
                       Image("Image 4")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 393,height: 336)
                     
                    }
                    .scaleEffect(size)
                  //  .opacity(opacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 1.2)){
                            self.size = 0.8
                            
                        }
                    }
                }
                
                .ignoresSafeArea()
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        
                        withAnimation{
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    SplashScreenView()
}
