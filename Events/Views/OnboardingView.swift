//
//  OnboardingView.swift
//  Events
//
//  Created by Norah Alfari on 10/06/1445 AH.
//

import SwiftUI


let images: [Onbording] = [
    Onbording(
        image: "image 1",
        title: "Explore Events",
        supTitle: "Browse through a variety of events effortlessly"),
    Onbording(
        image: "image 2",
        title: "Enjoy Events",
        supTitle: "Find events you love"),
    Onbording(
        image: "image 3",
        title: "Seamless Ticket Access",
        supTitle: "Access your event tickets seamlessly from your phone"),
]

struct OnboardingView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var current = 0
    @State var isCliced: Bool = false
    @State var isSecondScreenActive = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                VStack {
                    TabView(selection: $current){
                        ForEach(0..<3) { boarding in
                            VStack{
                                Image(images[boarding].image)
                                
                                Text(images[boarding].title)
                                    .bold()
                                    .font(.system(size: 40))
                                    .multilineTextAlignment(.center)
                                    .padding()
                                Text(images[boarding].supTitle)
                                    .font(.system(size: 20))
                                    .multilineTextAlignment(.center)
                                    .padding()
                                
                            }
                        }
                        
                    }
                    .tabViewStyle(PageTabViewStyle.init(indexDisplayMode: .never))
                    HStack{
                        ForEach(0 ..< 3){ i in
                            if i == current {
                                Circle()
                                    .frame(width: 12 , height: 12)
                                    .foregroundColor(Color.darkBlue)
                                
                                
                            } else {
                                Circle()
                                    .frame(width: 10 , height: 10)
                                    .foregroundColor(Color.darkBlue.opacity(0.3))
                            }
                        }
                    }
                    HStack{
                        Button {
                            isSecondScreenActive.toggle()
                            
                        } label: {
                            Label("Skip", systemImage: "" )
                                .labelStyle(.titleAndIcon)
                                .padding()
                                .frame(width: 152 ,height: 56)
                            
                                .padding()
                        }.accentColor(.black)
                        Spacer()
                        Button {
                            if (current != 2){
                                current+=1
                            } else {
                                isSecondScreenActive.toggle()
                                
                            }
                        } label: {
                            Label("Next", systemImage: "arrow.forward" )
                                .labelStyle(.titleAndIcon)
                                .padding()
                                .foregroundColor(.black)
                                .frame(width: 152 ,height: 56)
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                        .foregroundColor(Color.lightBlue ))
                                .padding()
                        }
                        
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                
                // MARK: TODO NAVIGATION
                NavigationLink(
                    destination: OrganizerSignInView(),
                    isActive: $isSecondScreenActive,
                    label: { EmptyView() }
                )
            }
            .navigationBarBackButtonHidden()
        }
    }
    
    
}

#Preview {
    OnboardingView()
}
