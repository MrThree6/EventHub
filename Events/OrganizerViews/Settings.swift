//
//  Settings.swift
//  Events
//
//  Created by Nosaibah Alrajhi on 25/12/2023.
//

import SwiftUI




let settings = [
    ProfileModel(
                 Image: "person",
                 title: "someone@email.com",
                 SupImage: ""),
    ProfileModel(Image: "globe",
                 title: "language",
                 SupImage: NSLocalizedString("English", comment: "")),
    
    ProfileModel(Image: "plus.app",
                 title: "Subscription",
                 SupImage: "free"),
   
 
    
]




struct Settings: View {
    @AppStorage("isDarkModeOn") private var isDarkModeOn: Bool = false
    @ObservedObject var vm: OrganizerRootViewModel
    var body: some View {
        ScrollView{
            VStack{
                
                Text("Settings")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading).padding()
                
                ForEach(settings) { profile in
                    Button {
                 
                            openSettings()
                       
                    } label: {
                        
                        
                        
                        
                        HStack{
                            Image(systemName: profile.Image).foregroundStyle(profile.title != "Delete Account" ? Color.lightBlue : Color.red)
                            Text(profile.title == "someone@email.com" ? vm.appUser!.email : profile.title).foregroundStyle(profile.title != "Delete Account" ? Color.primary : Color.red)
                            
                            Spacer()
                            Text(profile.SupImage).foregroundStyle(Color.darkGray2)
                        }.padding(.horizontal).frame(width: 335)
                        
                     //   Divider().frame(width: 335)
                    }.padding(.vertical, 4)
                }
                
                HStack{
                    Image(systemName: isDarkModeOn ? "moon" : "sun.min").foregroundStyle( Color.lightBlue )
                    
                    Toggle(isOn: $isDarkModeOn) {
                                            Text("Dark Mode")
                                        }.onChange(of: isDarkModeOn) { _ in
                                            // Toggle between dark and light mode
                                            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = isDarkModeOn ? .dark : .light
                                        }
                    
                    
                }.padding(.horizontal).frame(width: 335)
                
              //  Divider().frame(width: 335)
                
                
               

                
                
                
                
                
            }
            
            
            
        }
    }
}

func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }

        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }

#Preview {
    Settings(vm: OrganizerRootViewModel(appUser: AppUser(id: UUID(), name: "", email: "", isAdmin: true)))
}
