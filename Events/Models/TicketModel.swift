//
//  TicketModel.swift
//  Events
//
//  Created by Norah Alfari on 14/06/1445 AH.
//

import Foundation

struct TicketModel: Identifiable,Codable{
    var id: UUID
    var createdAt: String
    var userID: UUID
    var eventID: UUID
   
}
