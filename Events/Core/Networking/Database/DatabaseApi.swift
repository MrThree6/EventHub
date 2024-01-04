//
//  DatabaseApi.swift
//  EventHub
//
//  Created by Nosaibah Alrajhi on 23/12/2023.
//


import Foundation
import Supabase

enum DatabaseError: Error {
    case NotCreatedError
    case FetchError
}

protocol DatabaseApiProtocol {
    func addNewUser(user: AppUser) async throws
    func getUser(userId: UUID) async throws -> AppUser
    func addEvent(event: Event)async throws
   
}

class DatabaseApi: DatabaseApiProtocol {
    let client: SupabaseClient

    init(client: SupabaseClient) {
        self.client = client
    }
//
    func addNewUser(user: AppUser) async throws {
        do {
            try await client.database.from("users").insert(user).execute()
        } catch {
            print("DatabaseApi-addNewUser: \(error)")
            throw error
        }
    }
    // add
    func getUser(userId: UUID) async throws -> AppUser{
        do{
            let userData = try await client.database.from("users").select().eq("id", value: userId).execute()
            return try JSONDecoder().decode([AppUser].self, from: userData.data)[0]
        }catch{
            print("DatabaseApi-getUser: \(error)")
            throw error
        }
    }
    // add event
    func addEvent(event: Event) async throws {
        do {
            try await client.database.from("Event").insert(event).execute()
            print("add event excuted")
        } catch {
            print("DatabaseApi-addEvent: \(error)")
            throw error
        }
    }
    
    

}
