//
//  TicketDetails .swift
//  Events
//
//  Created by Norah Alfari on 10/06/1445 AH.
//

import SwiftUI

struct TicketDetails: View {
    @Environment(\.dismiss) var popview: DismissAction
    @StateObject var vm = EventViewModel()
    var eventId: UUID
    
    @ObservedObject var vm3: OrganizerRootViewModel
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            ForEach(vm.event){ event in
                if event.id == eventId{
                    VStack{
                        Text(event.name)
                            .bold()
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Divider()
                        
                        Text("Summary")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        HStack{
                            Image("date")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text(event.date)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        HStack{
                            Image("time")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text(event.time)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }
                        
                        
                        HStack{
                            Image("location")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text(event.place)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }
                        
                        
                        HStack{
                            Image("price")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("\(String(format: "%.f", event.price))SR")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.green)
                            
                        }
                        
                        
                        Divider()
                        
                    }.padding()
                    
                }
            }
            
            
            NavigationLink(destination: PaymentView(eventId: eventId, vm3: vm3), label: {
                Text("Book")
                    .foregroundColor(.black)
                    .background(RoundedRectangle(cornerRadius: 25)
                        .fill(.lightBlue)
                        .frame(width: 180, height: 50))
                
            }).padding()
        }
            .navigationTitle("Ticket Details")
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
    TicketDetails(eventId: UUID(), vm3: OrganizerRootViewModel(appUser: AppUser(id: UUID(), name: "", email: "", isAdmin: true)))
}
