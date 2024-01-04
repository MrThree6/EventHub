//
//  ProfileView.swift
//  EventHub
//
//  Created by Nosaibah Alrajhi on 23/12/2023.
//

import SwiftUI





//let Profile = [
//    ProfileModel(
//                 Image: "person",
//                 title: "My Profile",
//                 SupImage: "chevron.right", NavigationView: AnyView(EmptyView())),
//    
//    ProfileModel(Image: "gearshape",
//                 title: "Settings",
//                 SupImage: "chevron.right", NavigationView: AnyView(Settings( vm: vm))),
//    
//    
//    ProfileModel(Image: "rectangle.portrait.and.arrow.right",
//                 title: "Log Out",
//                 SupImage: "chevron.right", NavigationView: AnyView(OrganizerSignInView()))
//    
//]



struct ProfileView: View {
   @ObservedObject var vm: OrganizerRootViewModel
    
    
    var body: some View {
        VStack (spacing: 20){
            Text("Profile")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
            VStack{
                Image(systemName: "person").resizable().scaledToFit().frame(width: 30, height: 80).foregroundStyle(Color.darkGray2).background(
                    Circle().frame(width: 80).foregroundStyle(Color.darkGray1)).padding()
                Text(vm.appUser?.name ?? "name not found").font(.system(size: 20)).bold()
                
                
            }
            Spacer()
            
            
               
                    
                
            NavigationLink {
                
            } label: {
                
                
                
                
                HStack{
                    
                    Image(systemName: "person").foregroundStyle(Color.lightBlue)
                    Text("My Profile")
                    
                    Spacer()
                    Image(systemName: "chevron.forward")
                    
                }.padding(.horizontal).frame(width: 335)
                
              //  Divider().frame(width: 335)
                
                
            }
                           
            
            NavigationLink {
                
                Settings(vm: vm)
            } label: {
                
                
                
                
                HStack{
                    
                    Image(systemName: "gearshape").foregroundStyle(Color.lightBlue)
                    Text("Settings")
                    
                    Spacer()
                    Image(systemName: "chevron.forward")
                    
                }.padding(.horizontal).frame(width: 335)
                
               //Divider().frame(width: 335)
                
                
            }
            
            
            NavigationLink {
                OrganizerSignInView()
            } label: {
                
                
                
                
                HStack{
                    
                    Image(systemName: "rectangle.portrait.and.arrow.right").foregroundStyle(Color.lightBlue)
                    Text("logout")
                    
                    Spacer()
                    Image(systemName: "chevron.forward")
                    
                }.padding(.horizontal).frame(width: 335)
                
               // Divider().frame(width: 335)
                
                
            }

            
            Spacer()
            Spacer()

        }.navigationTitle("Profile")



    }
}



#Preview {
    ProfileView(vm: OrganizerRootViewModel(appUser: AppUser(id: UUID(), name: "", email: "", isAdmin: true)))
}
