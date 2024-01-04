//
//  OrganizerSignIn.swift
//  EventHub
//
//  Created by Nosaibah Alrajhi on 23/12/2023.
//

import SwiftUI

struct OrganizerSignInView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var isSecondScreenActive = false
    @State var isThirdScreenActive = false
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = AuthManager()
   // @Binding var isAdmin: Bool
    var body: some View {
      
            
            VStack {
                
                Text("Welcome to EventHub").font(.largeTitle).padding()
                
                Text("Sign in to your account by entering Email and Password").multilineTextAlignment(.center).padding()
                
                Spacer()

                
               
                AuthTextField(ImageName: "envelope", placeholder: NSLocalizedString("Enter your Email", comment: ""), keyboardType: .emailAddress, text: $vm.emailTextField, isLoading: $vm.isEmailLoading) {
                    await vm.emailValidatorSignIn(email: vm.emailTextField)
                }.padding(.vertical)

                AuthTextField(ImageName: "lock", placeholder: NSLocalizedString("Enter your Password", comment: ""), isSecure: true, text: $vm.passwordTextField, isLoading: .constant(false)).padding(.vertical)
                
                   
                    
                
                
                
                Text("[Forgot password ?](link)").font(.caption).foregroundStyle(Color.gray).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 35)
                
                Spacer()

                NavigationAsyncButton(
                    isFill: true,
                    title: "Sign in",
                    isActive: $vm.goToRootView,
                    isLoading: $vm.isSignInLoading,
                    action: vm.signIn,
                    destination: {vm.isAdmin ? AnyView(OrganizerRootView(vm: OrganizerRootViewModel(appUser: vm.appUser))) : AnyView(MyTabView(vm:OrganizerRootViewModel(appUser: vm.appUser))) }
                ).padding()
                
                HStack {
                    Text("Don’t have an account?").foregroundStyle(Color.gray).font(.subheadline)
                    Button {
                        
                        
                        isThirdScreenActive.toggle()
                    } label: {
                        Text("SignUp")
                            
                    }
                    
                }
                Spacer()
                
                
                NavigationLink(
                    destination: OrganizerSignUpView(),
                    isActive: $isThirdScreenActive,
                    label: { EmptyView() }
                )
             
                
            }.navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    OrganizerSignInView()
}
