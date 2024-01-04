//
//  EventpopUpView.swift
//  Events
//
//  Created by Nosaibah Alrajhi on 30/12/2023.
//

import SwiftUI

struct EventpopUpView: View {
    @Environment(\.dismiss) var popview: DismissAction
    
    var body: some View {
        ZStack {
            AddEventView(vm: OrganizerRootViewModel(appUser: nil))
            Color.black
                .opacity(0.5)
                .ignoresSafeArea()
            
            Button(action: {
                popview()
            }, label: {
                
            
                VStack {
                    Text("Action Successful")
                        .foregroundStyle(.black)
                        .font(.title)
                        .bold()
                    Image("Image")
                    
                    
                }
                .background(
                    Rectangle()
                    .frame(width: 365 ,height: 400)
                    .foregroundColor(.white)
                    .cornerRadius(30))
            })
         
            
           
            .padding()
        }
    }
    
}
#Preview {
    EventpopUpView()
}
