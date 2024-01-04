//
//  ProfileModel.swift
//  Events
//
//  Created by Nosaibah Alrajhi on 25/12/2023.
//

import Foundation
import SwiftUI

//MARK: 
struct ProfileModel: Identifiable {
    var id = UUID()
    var Image: String
    var title: String
    var SupImage: String
    var NavigationView : AnyView = AnyView(EmptyView())
}
