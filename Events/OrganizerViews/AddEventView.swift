//
//  AddEventView.swift
//  EventHub
//
//  Created by Nosaibah Alrajhi on 23/12/2023.
//

import SwiftUI

struct AddEventView: View {
    @State var Category :String = ""
    @State var Name :String = ""
    @State var Description :String = ""
    @State var Place :String = ""
    @State private var Date1 = Date.now
    @State var DateText :String = ""
    @State var TimeFrom :String = ""
    @State var TimeTo :String = ""
    @State var Price :String = ""
    @State var ImageURL : String = ""
    @ObservedObject var vm: OrganizerRootViewModel
    @StateObject var vm1: AddEventViewModel = AddEventViewModel(client: Shared.client)
    @State var isDatePickerShowing = false
    @State var latitude: String = ""
    @State var longitude: String = ""
    @State private var showSheet = false



    var body: some View {
        VStack {
            Text("Add Event")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
            ScrollView {
                VStack{
                    
                        
                            
                    TextField("Enter your Category",text: $Category).padding()
                        .background(Capsule().fill(.lightGray1).stroke(.darkGray1, lineWidth: 1)
                        ).padding()
                        
                    TextField("Enter your event name",text: $Name).padding()
                        .background(Capsule().fill(Color.lightGray1).stroke(Color.darkGray1, lineWidth: 1)
                        ).padding()
                    
                    TextField("Enter your Description",text: $Description).padding()
                        .background(Capsule().fill(Color.lightGray1).stroke(Color.darkGray1, lineWidth: 1)
                        ).padding()
                    
                    TextField("Enter your city",text: $Place).padding()
                        .background(Capsule().fill(Color.lightGray1).stroke(Color.darkGray1, lineWidth: 1)
                        ).padding()
                   
                    TextField("Enter your date",text: $DateText).padding()
                        .background(Capsule().fill(Color.lightGray1).stroke(Color.darkGray1, lineWidth: 1)
                        ).padding().onTapGesture {
                            isDatePickerShowing.toggle()
                        }
                    
                    HStack {
                        TextField("latitude",text: $latitude).padding()
                            .background(Capsule().fill(Color.lightGray1).stroke(Color.darkGray1, lineWidth: 1)
                            ).padding(.leading).keyboardType(.decimalPad)
                        
                        TextField("longitude",text: $longitude).padding()
                            .background(Capsule().fill(Color.lightGray1).stroke(Color.darkGray1, lineWidth: 1)
                            ).padding(.trailing).keyboardType(.decimalPad)
                    }
                    
                    
                    HStack {
                        TextField("Time From",text: $TimeFrom).padding()
                            .background(Capsule().fill(Color.lightGray1).stroke(Color.darkGray1, lineWidth: 1)
                            ).padding(.leading)
                        
                        TextField("Time To",text: $TimeTo).padding()
                            .background(Capsule().fill(Color.lightGray1).stroke(Color.darkGray1, lineWidth: 1)
                            ).padding(.trailing)
                    }
                    
                    TextField("Enter your price",text: $Price).padding()
                        .background(Capsule().fill(Color.lightGray1).stroke(Color.darkGray1, lineWidth: 1)
                        ).padding().keyboardType(.numberPad)
                    
                    
                    
                    TextField("Enter Image Url",text: $ImageURL).padding()
                        .background(Capsule().fill(Color.lightGray1).stroke(Color.darkGray1, lineWidth: 1)
                        ).padding()
                    
                    Button {
                        Task{
                            do{
                                try await vm1.addEvent(event: 
                                                        Event(image:  ImageURL , name: Name, description: Description, place: Place, date: Date1, time: "\(TimeFrom) - \(TimeTo)", price: Float(Double(Price) ?? 0), latitude: Float(Double(latitude) ?? 0), longitude: Float(Double(longitude) ?? 0), category: Category, userIDorganizer: vm.appUser!.id))
                                showSheet.toggle()

                            } catch{
                                print(error)
                            }
                        }
                        
                    } label: {
                        Label("Add Event", systemImage: "" )
                            .labelStyle(.titleAndIcon)
                            .padding()
                            .foregroundColor(.black)
                            .frame(width: 188 ,height: 52)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .foregroundColor(Color(.lightBlue) ))
                            
                    }.padding().fullScreenCover(isPresented: $showSheet) {
                        EventpopUpView()
                    }
                }.navigationTitle("Add Event")
            }
        }
        .sheet(isPresented: $isDatePickerShowing, content: {
            DatePicker("TestTitle", selection: $Date1, displayedComponents: .date)
                .padding()
                .tint(Color(.lightBlue))
                .presentationDetents([.fraction(0.5)])
                .datePickerStyle(.graphical)
                .onChange(of: Date1, { _, _ in
                    isDatePickerShowing.toggle()
                })
                .onChange(of: Date1) { _, _ in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd MMMM yyyy"
                    let dateString = dateFormatter.string(from: Date1)
                    DateText = dateString
                }

        })
    }
}

//#Preview {
//    AddEventView()
//}
