//
//  EventModel.swift
//  Events
//
//  Created by Norah Alfari on 12/06/1445 AH.
//

import Foundation

struct EventModel: Identifiable,Codable{
    var id: UUID
    var image: URL
    var name: String
    var description: String
    var place: String
    var date: String
    var time: String
    var price: Double
    var latitude: Double?
    var longitude: Double?
    var category: String
    var userIDorganizer: UUID?
    
}
