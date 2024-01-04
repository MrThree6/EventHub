//
//  OrganizerHomeViewModel.swift
//  Events
//
//  Created by Nosaibah Alrajhi on 30/12/2023.
//

import Foundation
import Supabase
class OrganizerHomeViewModel : ObservableObject{
   
   @Published var events : [EventModel] = []
    var client: SupabaseClient
    init() {
        self.client = Shared.client
    }
    
    func addEvent(event: Event) async throws {
        do {
            try await client.database.from("Event").insert(event).execute()
            print("ADD event: excuted!")
        } catch {
            print("AddEventModel-addEvent: \(error)")
            throw error
        }
    }
    
    func getEvents(userId: UUID) async throws {
        do{
            let userData = try await client.database.from("Event").select().eq("userIDorganizer", value: userId).execute()
            
             try events = JSONDecoder().decode([EventModel].self, from: userData.data)//[0]
            
            print("GET event: excuted!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            print(events)
        }catch{
            print("OrganizerHomeViewModel - GET EVENT: \(error)")
            //throw error
        }
    }
    
    
    
    
}
