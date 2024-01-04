//
//  EventDetails.swift
//  Events
//
//  Created by Norah Alfari on 10/06/1445 AH.
//

import SwiftUI
import MapKit

struct EventDetails: View {
    @Environment(\.dismiss) var popview: DismissAction
    @StateObject var vm = EventViewModel()
    @ObservedObject var vm3: OrganizerRootViewModel
    
    var eventId: UUID
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            ForEach(vm.event){event in
                if event.id == eventId{
                    VStack{
                        AsyncImage(url: event.image) { result in
                            if let image = result.image {
                                image
                                    .resizable()
                                    .frame(width: 360, height: 160)
                                    .cornerRadius(15)
                                    .scaledToFill()
                            } else {
                                ProgressView()
                                    .frame(width: 360, height: 160)
                                    .cornerRadius(15)
                                    .tint(.gray)
                            }
                        }
                        
                        
                        Text(event.name)
                            .bold()
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(event.description)
                            .multilineTextAlignment(.leading)
                            .font(.caption)
                        
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
                        
                        
                        
                        Map{
                            Annotation(event.place, coordinate: CLLocationCoordinate2D(latitude: event.latitude ?? 0.00, longitude: event.longitude ?? 0.00)) {
                                
                                Image(systemName: "mappin")
                                    .foregroundColor(.darkBlue)
                                
                            }
                        }.frame(width: 360, height: 230)
                            .cornerRadius(15)
                        
                        
                        
                    }.padding()
                }
        }
            
            NavigationLink(destination: TicketDetails(eventId: eventId, vm3: vm3 ), label: {
                Text("Tickets")
                    .foregroundColor(.black)
                    .background(RoundedRectangle(cornerRadius: 25)
                        .fill(.lightBlue)
                        .frame(width: 180, height: 50))
                
            }).padding()
            
            
            
        }
            
            
                .navigationTitle("Event Details")
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
    EventDetails(vm3: OrganizerRootViewModel(appUser: AppUser(id: UUID(), name: "", email: "", isAdmin: true)), eventId: UUID())
}
