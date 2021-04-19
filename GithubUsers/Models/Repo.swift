import Foundation
import SwiftUI

struct Repo: Hashable, Identifiable, Decodable {
    var id: Int64
    var name: String
    var full_name: String
    var created_at: String
    var updated_at: String
}
