//
//  Event.swift
//  Events
//
//  Created by Nosaibah Alrajhi on 29/12/2023.
//

import Foundation


struct  Event : Codable{
    var image: String
    var name : String
    var description: String
    var place: String
    var date : Date
    var time : String
    var price: Float
    var latitude: Float
    var longitude: Float
    var category: String
    var userIDorganizer: UUID
    
}
    
