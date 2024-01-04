//
//  EventsView.swift
//  Events
//
//  Created by Norah Alfari on 10/06/1445 AH.
//

import SwiftUI

struct EventsView: View {
    @Environment(\.dismiss) var popview: DismissAction
    @StateObject var vm = EventViewModel()
    @StateObject var vm1 = FavouriteViewModel()
    @ObservedObject var vm3: OrganizerRootViewModel
    var eventCategory: String
    
  
    @State private var favoriteStates: [UUID: Bool] = [:]
    
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(spacing: 32.0){
                
                ForEach(vm.event){event in
                    if event.category == eventCategory{
                        
                        HStack{
                            NavigationLink(destination: EventDetails(vm3: vm3, eventId: event.id)){
                                
                                AsyncImage(url: event.image) { result in
                                    if let image = result.image {
                                        image
                                            .resizable()
                                            .frame(width: 120, height: 125)
                                            .cornerRadius(15)
                                            .padding()
                                            .scaledToFill()
                                    } else {
                                        ProgressView()
                                            .frame(width: 120, height: 125)
                                            .cornerRadius(15)
                                            .tint(.gray)
                                    }
                                }
                                
                            }
                            VStack{
                                Text(event.category)
                                    .padding(.horizontal)
                                    .background(RoundedRectangle(cornerRadius: 5)
                                        .fill(.lightBlue))
                                    .foregroundColor(.black)
                                    .font(.caption)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                HStack{
                                    Image("ticket")
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                    Text(event.name)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                }.foregroundColor(.black)
                                    .font(.caption)
                                
                                HStack{
                                    Image("date")
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                    Text(event.date)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                }.foregroundColor(.black)
                                    .font(.caption)
                                
                                HStack{
                                    Image("location")
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                    Text(event.place)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.caption)
                                    
                                    Button {
                                        toggleFavoriteState(event: event)
                                    } label: {
                                        Image(systemName: favoriteStates[event.id] == true ? "heart.fill" : "heart")
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                            .padding(.horizontal)
                                    }
                                    
                                }.foregroundColor(.black)
                                
                            }
                            
                        } .background(RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.darkGray1)
                            .frame(width: 360, height: 160 ))
                        
                    }
                }
                
                
                
            }.padding()
        }
        
        .navigationTitle("Events")
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
    
    private func toggleFavoriteState(event: EventModel) {
        var userId = vm3.appUser?.id
            favoriteStates[event.id] = true
        vm1.addFavourite(userID: userId!, eventID: event.id, isFavourite: true)

    }
}

#Preview {
    EventsView(vm3: OrganizerRootViewModel(appUser: AppUser(id: UUID(), name: "", email: "", isAdmin: true)), eventCategory: "")
}
