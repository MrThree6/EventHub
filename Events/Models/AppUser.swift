

import Foundation

struct AppUser: Codable {
    let id: UUID
    let name: String
    let email: String
    let isAdmin: Bool
    

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case isAdmin
        
        
    }

    init(id: UUID, name: String, email: String, isAdmin: Bool) {
        self.id = id
        self.name = name
        self.email = email
        self.isAdmin = isAdmin

       
    }

    

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        isAdmin = try container.decode(Bool.self, forKey: .isAdmin)
 
    }
}
