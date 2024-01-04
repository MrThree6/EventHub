//
//  Favourite.swift
//  Events
//
//  Created by Norah Alfari on 13/06/1445 AH.
//

import Foundation


struct FavouriteModel: Identifiable,Codable{
    var id: UUID
    var userID: UUID
    var eventID: UUID
    var isFavourite: Bool
    
}
