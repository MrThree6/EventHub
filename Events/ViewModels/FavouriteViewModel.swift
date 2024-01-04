//
//  FavouriteViewModel.swift
//  Events
//
//  Created by Norah Alfari on 13/06/1445 AH.
//

import Foundation

class FavouriteViewModel: ObservableObject{
    @Published var favourite : [FavouriteModel] = []
    
    init(){
        fetchData()
    }
    
    func fetchData(){
        let url = URL(string: "https://ppgtmjfwwqgkotohbper.supabase.co/rest/v1/Favourite?select=*")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Set your headers here
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBwZ3RtamZ3d3Fna290b2hicGVyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMxNDMwMjQsImV4cCI6MjAxODcxOTAyNH0.c0cbKfHqQx2fiWb6ISfKnf29-Ea5aaRbyZyzcVGAcNc", forHTTPHeaderField: "apikey")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBwZ3RtamZ3d3Fna290b2hicGVyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMxNDMwMjQsImV4cCI6MjAxODcxOTAyNH0.c0cbKfHqQx2fiWb6ISfKnf29-Ea5aaRbyZyzcVGAcNc", forHTTPHeaderField: "Authorization")

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error with fetching data: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }

            guard let data = data else{
                print("no data recived")
                return
            }
            
            print(data)
            
            let  decoder = JSONDecoder()// تفك الترميز الي سوفت
            
            do{
                self.favourite  = try decoder.decode([FavouriteModel].self, from: data)
                print(self.favourite)//تطبع لي المعلومات
                print("---------------------------------------------")
            }
            catch{
                print("error\(error)")//عشان  يطلع لي الايرور
            }
        }

        task.resume()
        
        
    }
    
    func addFavourite(userID: UUID, eventID: UUID,isFavourite: Bool){
         let url = URL(string: "https://ppgtmjfwwqgkotohbper.supabase.co/rest/v1/Favourite?select=*")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Set your headers here
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBwZ3RtamZ3d3Fna290b2hicGVyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMxNDMwMjQsImV4cCI6MjAxODcxOTAyNH0.c0cbKfHqQx2fiWb6ISfKnf29-Ea5aaRbyZyzcVGAcNc", forHTTPHeaderField: "apikey")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBwZ3RtamZ3d3Fna290b2hicGVyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMxNDMwMjQsImV4cCI6MjAxODcxOTAyNH0.c0cbKfHqQx2fiWb6ISfKnf29-Ea5aaRbyZyzcVGAcNc", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("return=minimal", forHTTPHeaderField: "Prefer")

        // Start of JSON data definition
        let jsonString = """
        {
            "userID": "\(userID)",
            "eventID": "\(eventID)",
        "isFavourite": "\(isFavourite)"
        }
        """

        // Converting JSON String to Data
        let jsonData = jsonString.data(using: .utf8)!

        // Setting the JSON data as the HTTP request body
        request.httpBody = jsonData

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error with fetching data: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: Did not receive a valid HTTP response")
                return
            }

            if (200...299).contains(httpResponse.statusCode) {
                print("New row added successfully with status code: \(httpResponse.statusCode)")
            } else {
                print("Failed to add new row with status code: \(httpResponse.statusCode)")
            }
        }

        task.resume()
        
    }
    
    
    func deleteFavourite(id: UUID){
        let url = URL(string: "https://ppgtmjfwwqgkotohbper.supabase.co/rest/v1/Favourite?id=eq.\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        // Set your headers here
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBwZ3RtamZ3d3Fna290b2hicGVyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMxNDMwMjQsImV4cCI6MjAxODcxOTAyNH0.c0cbKfHqQx2fiWb6ISfKnf29-Ea5aaRbyZyzcVGAcNc", forHTTPHeaderField: "apikey")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBwZ3RtamZ3d3Fna290b2hicGVyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMxNDMwMjQsImV4cCI6MjAxODcxOTAyNH0.c0cbKfHqQx2fiWb6ISfKnf29-Ea5aaRbyZyzcVGAcNc", forHTTPHeaderField: "Authorization")

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error with fetching data: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: Did not receive a valid HTTP response")
                return
            }

            if (200...299).contains(httpResponse.statusCode) {
                print("Row deleted successfully with status code: \(httpResponse.statusCode)")
            } else {
                print("Failed to delete row with status code: \(httpResponse.statusCode)")
            }
        }

        task.resume()
    }
    
}
