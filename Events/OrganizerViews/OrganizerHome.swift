//
//  OrganizerHome.swift
//  EventHub
//
//  Created by Nosaibah Alrajhi on 23/12/2023.
//

import SwiftUI

struct OrganizerHome: View {
    @ObservedObject var vm: OrganizerRootViewModel
    @StateObject var EventVM = OrganizerHomeViewModel()
    var body: some View {
      
        VStack {
            Text("Events")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
            
            
            ScrollView {
                if EventVM.events.isEmpty {
                   ProgressView()
                } else {
                    
                    ForEach(EventVM.events){ event in
                        HStack(){
                            
                            AsyncImage(url:  event.image) { result in
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
                            
                            VStack(alignment: .leading){
                                
                                ZStack {
                                    
                                    RoundedRectangle(cornerRadius: 5).fill(Color.lightBlue).frame(width: 80, height: 24)
                                    Text(event.category)
                                }.padding(.leading)
                                
                                HStack {
                                    Image(systemName: "ticket").foregroundStyle(Color.gray)
                                    Text(event.name)
                                }
                                
                                HStack {
                                    Image(systemName: "calendar.badge.checkmark").foregroundStyle(Color.gray)
                                    Text(event.date)
                                }
                                
                                HStack {
                                    Image(systemName: "mappin").foregroundStyle(Color.gray)
                                    Text(event.place)
                                }
                            }
                            Spacer()
                        }.frame(width: 370, height: 150).background(RoundedRectangle(cornerRadius: 11.13).stroke(.darkGray1, lineWidth: 1).frame(width: 360, height: 150))
                    }
                }
            }
        }.navigationTitle("Events").task {
            Task {
                do{
                    
                    try await EventVM.getEvents(userId: vm.appUser!.id)
                
                } catch{
                    print(error)
                }
            }
        }
    }
}

#Preview {
    OrganizerHome(vm: OrganizerRootViewModel(appUser: AppUser(id: UUID(), name: "", email: "", isAdmin: true)))
}
