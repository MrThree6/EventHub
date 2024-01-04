//
//  TicketsViewModel.swift
//  Events
//
//  Created by Nosaibah Alrajhi on 30/12/2023.
//

import Foundation
import Supabase



class TicketsViewModel : ObservableObject{
   
   @Published var tickets : [TicketModel] = []
    var client: SupabaseClient
    init() {
        self.client = Shared.client
    }
    
    func getTicket(userId: UUID) async throws {
        do{
            let userData = try await client.database.from("Tickts").select().eq("userIDorganizer", value: userId).execute()
            
             try tickets = JSONDecoder().decode([TicketModel].self, from: userData.data)//[0]
            
            print("GET ticket: excuted!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            print(tickets)
        }catch{
            print("OrganizerHomeViewModel - GET EVENT: \(error)")
            //throw error
        }
    }
    
    
    
    
}
