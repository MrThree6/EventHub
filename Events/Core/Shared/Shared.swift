

import Foundation
import Supabase

struct Shared {
    static let client = SupabaseClient(supabaseURL: Secret.apiUrl, supabaseKey: Secret.apiKey)
}
