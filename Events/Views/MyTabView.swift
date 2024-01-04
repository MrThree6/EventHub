//
//  TabView.swift
//  Events
//
//  Created by Norah Alfari on 10/06/1445 AH.
//

import SwiftUI

struct MyTabView: View {
    @ObservedObject var vm: OrganizerRootViewModel
    
    var body: some View {
        
        
        
            TabView {
               
                HomeView(vm2: vm)
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                
                
                SearchView(vm3: vm)
                    
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                
                Faviourts(vm2: vm)
                    .tabItem {
                        Image(systemName: "heart")
                        Text("Faviourts")
                    }
                
                
                YourTickets(vm2: vm)
                    .tabItem {
                        Image(systemName: "ticket")
                        Text("Tickets")
                    }
                UserProfileView(vm: vm)
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                
               
            }.navigationBarBackButtonHidden(true)
            .accentColor(.lightBlue)
        
        
    }
}

#Preview {
    MyTabView(vm: OrganizerRootViewModel(appUser: AppUser(id: UUID(), name: "", email: "", isAdmin: true)))
}
