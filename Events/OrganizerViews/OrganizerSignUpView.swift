//
//  OrganizerSignUpView.swift
//  EventHub
//
//  Created by Nosaibah Alrajhi on 23/12/2023.
//

import SwiftUI

struct OrganizerSignUpView: View {
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var isSecondScreenActive = false
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = AuthManager()
    @State private var agreedToTerms: Bool = false
    var body: some View {
      
            
            VStack {
                
                Text("Welcome to EventHub").font(.largeTitle).padding()
                
                Text("Create your Account").multilineTextAlignment(.center).padding()
                
                Spacer()

                
                
                
               
                
                
                
                
                
                
                
                AuthTextField(ImageName: "person", placeholder: "Enter your Name", text: $vm.nameTextField, isLoading: .constant(false)).padding(.vertical)
                
                AuthTextField(ImageName: "envelope", placeholder: "Enter your Email", keyboardType: .emailAddress, text: $vm.emailTextField, isLoading: $vm.isEmailLoading) {
                    await vm.emailValidatorSignUp(email: vm.emailTextField)
                }.padding(.vertical)

                AuthTextField(ImageName: "lock", placeholder: "Enter your Password", isSecure: true, text: $vm.passwordTextField, isLoading: .constant(false)) {
                    vm.passwordValidator(password: vm.passwordTextField)
                }.padding(.vertical)
                
                HStack {
                    Image(systemName: vm.isAdmin ? "checkmark.square" : "square")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .onTapGesture {
                                                vm.isAdmin.toggle()
                                            }.animation(.bouncy)

                                        Text("Organizer Account")
                                            .onTapGesture {
                                                vm.isAdmin.toggle()
                                            }
                }.frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal,24).foregroundStyle(Color.darkGray2)
                
                
                
                Spacer()

                NavigationAsyncButton(
                    isFill: true,
                    title: "Create Account",
                    isActive: $vm.goToRootView,
                    isLoading: $vm.isSignUpLoading,
                    action: vm.signUp,
                    destination: { vm.isAdmin ?
                        AnyView(OrganizerRootView(vm: OrganizerRootViewModel(appUser: vm.appUser))) : AnyView(MyTabView(vm: OrganizerRootViewModel(appUser: vm.appUser))) }
                ).padding()
//                Button {
//                    isSecondScreenActive.toggle()
//                } label: {
//                    Label("Sign Up", systemImage: "" )
//                        .labelStyle(.titleAndIcon)
//                        .padding()
//                        .foregroundColor(.black)
//                        .frame(width: 332 ,height: 50)
//                        .background(
//                            RoundedRectangle(cornerRadius: 30)
//                                .foregroundColor(Color(.lightBlue) ))
//                        
//                }.padding()
                
                
                Spacer()

//                                NavigationLink(
//                                    destination: OrganizerRootView(), //MARK: Navigation view
//                                    isActive: $isSecondScreenActive,
//                                    label: { EmptyView() }
//                                )
                
            }
        
    }
}

#Preview {
    OrganizerSignUpView()
}
