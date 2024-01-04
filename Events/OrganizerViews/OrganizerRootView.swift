//
//  OraganizerRootView.swift
//  EventHub
//
//  Created by Nosaibah Alrajhi on 23/12/2023.
//

import SwiftUI

struct OrganizerRootView: View {
    @ObservedObject var vm: OrganizerRootViewModel

    var body: some View {
        NavigationStack {
            TabView {
                OrganizerHome(vm: vm)
                         .tabItem {
                             Image(systemName: "house")
                             Text("Home")
                         }.scrollIndicators(.hidden)
                     
                AddEventView(vm : vm)
                         .tabItem {
                             Image(systemName: "plus.circle.fill")
                             Text("Add events")
                         }
                
                TicketsView(uservm: vm)
                     .tabItem {
                         Image(systemName: "ticket")
                         Text("Tickets")
                     }
               
                ProfileView(vm : vm)
                     .tabItem {
                         Image(systemName: "person")
                         Text("Profile")
                     }
                     

            }.toolbar(){
                ToolbarItem(){}
            }
                .navigationBarBackButtonHidden(true)
                .tint(.lightBlue)
        }
    }
}

//#Preview {
//    OrganizerRootView()
//}
