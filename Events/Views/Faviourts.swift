//
//  Faviourts.swift
//  Events
//
//  Created by Norah Alfari on 10/06/1445 AH.
//

import SwiftUI

struct Faviourts: View {
    @StateObject var vm = EventViewModel()
    @StateObject var vm1 = FavouriteViewModel()
//    @State var isFavourite = true
    @State private var favoriteStates: [UUID: Bool] = [:]
    
    
    @ObservedObject var vm2: OrganizerRootViewModel
    
    
    var body: some View {
        ScrollView(showsIndicators: false){
            
            let userId = vm2.appUser?.id
            VStack(spacing: 32.0){
                Text("Favourite")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)

                ForEach(vm1.favourite) {favourite in
                    
                    ForEach(vm.event){event in
                        if event.id == favourite.eventID && favourite.userID == userId {
                            HStack{
                                NavigationLink(destination: EventDetails( vm3: vm2,eventId: event.id)){
                                    
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
                                            toggleFavoriteState(event: favourite)
                                        } label: {
                                            Image(systemName: favoriteStates[event.id] == true ? "heart" : "heart.fill")
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
                }
                
            
                
            }.padding()
                .onAppear(){
                    vm1.fetchData()
                    vm.fetchData()
                }
        }
    }
    private func toggleFavoriteState(event: FavouriteModel) {
            favoriteStates[event.id] = true
            vm1.deleteFavourite(id: event.id)

    }
}

#Preview {
    Faviourts(vm2: OrganizerRootViewModel(appUser: AppUser(id: UUID(), name: "", email: "", isAdmin: true)))
}
