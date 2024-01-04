//
//  OrganizerRootViewModel.swift
//  Events
//
//  Created by Nosaibah Alrajhi on 29/12/2023.
//

import Foundation
class OrganizerRootViewModel: ObservableObject{
  
    let appUser: AppUser? 
    
    
    init(appUser: AppUser?) {
        self.appUser = appUser
    }
}
