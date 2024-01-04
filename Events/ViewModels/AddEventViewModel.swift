//
//  AddEventViewModel.swift
//  Events
//
//  Created by Nosaibah Alrajhi on 29/12/2023.
//

import Foundation
import Supabase
class AddEventViewModel : ObservableObject{
    var image: String = ""
    var name : String = ""
    var description: String = ""
    var place: String = ""
    var date : Date = Date()
    var time : String = ""
    var price: Float = 0.0
    var latitude: Float = 0.0
    var longitude: Float = 0.0
    var category: String = ""
    //var userIDorganizer: UUID = UUID()
    
    var client: SupabaseClient = Shared.client
    init(client: SupabaseClient) {
        self.client = client
    }
    
    func addEvent(event: Event) async throws {
        do {
            try await client.database.from("Event").insert(event).execute()
            print("add event excuted")
        } catch {
            print("AddEventModel-addEvent: \(error)")
            throw error
        }
    }
    
    
    
    
    
}
