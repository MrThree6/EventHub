//
//  PopupView.swift
//  Events
//
//  Created by Norah Alfari on 10/06/1445 AH.
//

import SwiftUI

struct PopupView: View {
    @Environment(\.dismiss) var popview: DismissAction
    
    var body: some View {
        ZStack {
            PaymentView(eventId: UUID(), vm3: OrganizerRootViewModel(appUser: AppUser(id: UUID(), name: "", email: "", isAdmin: true)))
            Color.black
                .opacity(0.5)
                .ignoresSafeArea()
            
            Button(action: {
                popview()
            }, label: {
                
            
                VStack {
                    Text("Booking Successful")
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
    PopupView()
}
