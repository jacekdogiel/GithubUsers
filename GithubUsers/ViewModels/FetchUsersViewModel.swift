//
//  FetchUsersViewModel.swift
//  GithubUsers
//
//  Created by Jacek Dogiel on 19/04/2021.
//

import SwiftUI
import Combine

final class FetchUsersViewModel: ObservableObject {

    @Published var name = ""

    @Published private(set) var users = [User]()

    @Published private(set) var userImages = [User: UIImage]()
    
    var usersListFull = false
    var since: Int64 = 0
    let perPage = 20

    private var fetchCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        fetchCancellable?.cancel()
    }

    func fetchUsers() {
        
        let url = URL(string: "https://api.github.com/users?since=\(since)")!
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        fetchCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: [User].self, decoder: JSONDecoder())
            .map { $0 }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .catch { _ in Just(self.users) }
            .sink { [weak self] in
                print(self?.since ?? 0)
                self?.users.append(contentsOf: $0)
                self?.since = self?.users.last?.id ?? 0
                if $0.count < self!.perPage {
                    self?.usersListFull = true
                }
            }
    }

    func fetchImage(for user: User) {
        guard case .none = userImages[user] else {
            return
        }
        
        URLSession.shared.dataTask(with: user.avatar_url) {[weak self] data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.userImages[user] = UIImage(data: data)
            }
            
        }.resume()
    }
}
