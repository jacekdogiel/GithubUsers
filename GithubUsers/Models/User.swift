import Foundation
import SwiftUI

struct User: Hashable, Identifiable, Decodable {
    var id: Int64
    var login: String
    var avatar_url: URL
    var repos_url: URL
    var html_url: URL
}
