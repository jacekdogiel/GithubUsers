//
//  UserRepoViewModel.swift
//  GithubUsers
//
//  Created by Jacek Dogiel on 19/04/2021.
//

import SwiftUI
import Combine

final class UserRepoViewModel: ObservableObject {

    @Published private(set) var repos = [Repo]()

    private var fetchCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        fetchCancellable?.cancel()
    }

    func fetchUserRepos(for url: URL) {
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        fetchCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: [Repo].self, decoder: JSONDecoder())
            .map { $0 }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.repos, on: self)
    }
}
