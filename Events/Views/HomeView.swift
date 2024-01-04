//
//  HomeView.swift
//  Events
//
//  Created by Norah Alfari on 09/06/1445 AH.
//
import SwiftUI

struct HomeView: View {
    @StateObject var vm = EventViewModel()
    @ObservedObject var vm2: OrganizerRootViewModel
    
    var body: some View {
      
            
            ScrollView (showsIndicators: false){
                VStack(spacing: 8.0){
                    Text("Explore")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)

                    //Categories
                    Text("Categories")
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(){
                            ForEach(allItems){ item in
                                
                                VStack{
                                    NavigationLink(destination: EventsView(vm3: vm2, eventCategory: item.title), label: {
                                        Image(item.imageName)
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .background(Circle()
                                                .fill(.lightBlue)
                                                .frame(width: 60, height: 60))
                                            .padding(.vertical, 10)
                                    })
                                    Text(item.title)
                                        .font(.caption2)
                                        .bold()
                                    
                                }.padding(.horizontal)
                                    .padding(.vertical, 8)
                            }
                        }
                    }
                    
                    //Trending Events
                    Text("Trending Events")
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    
                    ForEach(vm.event){event in
                        NavigationLink(destination: EventDetails(vm3: vm2, eventId: event.id)){
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
                                
         
                                HStack{
                                    Text(event.name)
                                    Spacer()
                                    Image("location")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    Text(event.place)
                                }.foregroundStyle(Color.black)
                                    .font(.caption)
                                    .padding(8)
                                    
                            } .background(RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.darkGray1))
                        }
                    }
                    
                 
                    
                }.padding()
            }
          
    }
}

struct Item: Identifiable {
    var id = UUID()
    var imageName: String
    var title: String
    
}

var allItems = [
    Item(imageName: "Art", title:"Art"),
    Item(imageName: "Food", title:"Food"),
    Item(imageName: "Education", title:"Cultural"),
    Item(imageName: "Gaming", title:"Gaming"),
    Item(imageName: "Tech", title:"Tech")
]

#Preview {
    HomeView(vm2: OrganizerRootViewModel(appUser: AppUser(id: UUID(), name: "", email: "", isAdmin: true)))
}
