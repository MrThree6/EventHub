//
//  EventViewModel.swift
//  Events
//
//  Created by Norah Alfari on 12/06/1445 AH.
//

import Foundation

class EventViewModel:ObservableObject{
    @Published var event : [EventModel] = []
    
    init(){
        fetchData()
    }
    
    
    func fetchData(){
        let url = URL(string: "https://ppgtmjfwwqgkotohbper.supabase.co/rest/v1/Event?select=*")!
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
                self.event  = try decoder.decode([EventModel].self, from: data)
                print(self.event)//تطبع لي المعلومات
                print("---------------------------------------------")
            }
            catch{
                print("error\(error)")//عشان  يطلع لي الايرور
            }
        }

        task.resume()
        
        
    }
 
    
    
    
}
