//
//  YourTickets.swift
//  Events
//
//  Created by Norah Alfari on 10/06/1445 AH.
//

import SwiftUI

struct YourTickets: View {
    @StateObject var vm = TicketViewModel()
    @StateObject var vm1 = EventViewModel()
    
    @ObservedObject var vm2: OrganizerRootViewModel
    
    var body: some View {
        VStack(){
            let userId = vm2.appUser?.id
            Text("Tickets")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            ScrollView(showsIndicators: false){
                
                ForEach(vm.ticket){ticket in
                    ForEach(vm1.event){event in
                        if event.id == ticket.eventID && ticket.userID == userId{
                            
                            VStack(){
                                    
                                    HStack{
                                        Image(systemName: "number.square")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundStyle(Color.darkGray2)
                                        Text("Ticket ID")
                                           
                                    }
                                    HStack{
                                        
                                        Text("\(ticket.id)")
                                            .font(.caption2)
                                            .foregroundStyle(Color.darkGray2)
                                           
                                    }
                                    
                                    HStack{
                                        Image("ticket")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        Text(event.name)
                                           
                                    }
                                    
                                    HStack{
                                        Image("date")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        Text(event.date)
                                           
                                    }
                                    HStack{
                                        Image("time")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        Text(event.time)
                                            
                                        
                                    }
                                    
                                    
                                    HStack{
                                        Image("location")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        Text(event.place)
                                         
                                    }
                                    HStack{
                                        Image("price")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        Text("\(String(format: "%.f", event.price))SR")
                                            
                                            .foregroundColor(.green)
                                        
                                    }
                                    
                                    Image("BarCode")

                                    
                                }.padding()
                            .font(.callout)
                                    .background(
                                        Image("MyTicket")
                                            .resizable()
                                            
                                    ).padding()
                                
                               
                        }
                    }
                    
                }
            }
            
            
        }
    }
}

#Preview {
    YourTickets(vm2: OrganizerRootViewModel(appUser: AppUser(id: UUID(), name: "", email: "", isAdmin: true)))
}
