//
//  TicketsView.swift
//  EventHub
//
//  Created by Nosaibah Alrajhi on 23/12/2023.
//

import SwiftUI

struct TicketsView: View {
    @StateObject var ticketvm = TicketViewModel()
    @StateObject var eventvm = EventViewModel()
    
    @ObservedObject var uservm: OrganizerRootViewModel
    
    var body: some View {
       
        VStack {
            let organizerID = uservm.appUser?.id
            Text("Tickets")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
            ScrollView {
                
                if ticketvm.ticket.isEmpty || eventvm.event.isEmpty  {
                   ProgressView()
                } else {
                    
                    
                    ForEach(ticketvm.ticket){ ticket in
                        ForEach(eventvm.event){ event in
                            if event.userIDorganizer == organizerID && ticket.eventID == event.id{
                                
                                VStack(alignment: .leading){
                                    
                                    Text("Event Name:")
                                    Text("\(event.name)").foregroundStyle(Color.darkGray2)
                                    
                                    
                                    Text("Booking Date:")
                                    Text("\(ticket.createdAt)").foregroundStyle(Color.darkGray2)
                                    
                                    
                                    Text("Ticket ID:")
                                    Text("\(ticket.id)").foregroundStyle(Color.darkGray2)
                                    
                                    
                                    Text("User ID")
                                    Text("\(ticket.userID)").foregroundStyle(Color.darkGray2)
                                    
                                    
                                    
                                    
                                    
                                }.padding(.horizontal, 32.0).frame(width: 370, height: 300).background(RoundedRectangle(cornerRadius: 11.13).stroke(Color.darkGray1, lineWidth: 1).frame(width: 360, height: 300)).navigationTitle("Tickets")
                                
                            }
                        }
                    }
                    
                    
                }
                
            }
        }.onAppear(){
            ticketvm.fetchData()
        }
    }
}

#Preview {
    TicketsView(uservm: OrganizerRootViewModel(appUser: AppUser(id: UUID(), name: "", email: "", isAdmin: true)))
}
