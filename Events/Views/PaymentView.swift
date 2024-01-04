//
//  PaymentView.swift
//  Events
//
//  Created by Norah Alfari on 10/06/1445 AH.
//

import SwiftUI

struct PaymentView: View {
    @Environment(\.dismiss) var popview: DismissAction
    @StateObject var vm = TicketViewModel()
    
    
    
    @State var name = ""
    @State var cardNumber = ""
    @State var YM = ""
    @State var cvv = ""
    
    @State private var showSheet = false
    
    var eventId: UUID
    @ObservedObject var vm3: OrganizerRootViewModel
    
    
    
    let date = Date()
    func formatDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack(){
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.darkGray1)
                        .frame(width: 360, height: 48)
                    TextField("Name", text: $name)
                        .padding(.horizontal, 48)
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.darkGray1)
                        .frame(width: 360, height: 48)
                    TextField("Card Number", text: $cardNumber)
                        .padding(.horizontal, 48)
                        .keyboardType(.numberPad)
                }
                
                HStack(spacing: 0){
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.darkGray1)
                            .frame(width: 160, height: 48)
                        TextField("Y/M", text: $YM)
                            .padding(.horizontal, 24)
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.darkGray1)
                            .frame(width: 160, height: 48)
                        TextField("CVV", text: $cvv)
                            .padding(.horizontal, 24)
                    }
                    
                    
                }
              
                
            }
                
            }
       
        Button(action: {
            showSheet.toggle()
            let userId = vm3.appUser?.id ?? UUID()
            vm.addTicket(createdAt: (formatDateToString(_:date)), userID: userId, eventID: eventId)
        }, label: {
            Text("Pay")
                .foregroundColor(.black)
                .background(RoundedRectangle(cornerRadius: 25)
                    .fill(.lightBlue)
                    .frame(width: 180, height: 50))
                .padding()
        }).fullScreenCover(isPresented: $showSheet) {
            PopupView()
        }
        
         
            .navigationTitle("Payment")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
            Button(action: {
                popview()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            })
        )
        
    }
}



#Preview {
    PaymentView(eventId: UUID(), vm3: OrganizerRootViewModel(appUser: AppUser(id: UUID(), name: "", email: "", isAdmin: true)))
}
