//
//  UsersView.swift
//  GithubUsers
//
//  Created by Jacek Dogiel on 19/04/2021.
//

import SwiftUI

struct UsersView: View {
    @ObservedObject var viewModel = FetchUsersViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.users) { user in
                        NavigationLink(destination: UserRepoView(url: user.repos_url, pageURL: user.html_url, login: user.login)) {
                            
                            UserRow(viewModel: self.viewModel, user: user)
                                .onAppear { self.viewModel.fetchImage(for: user) }
                        }
                    }
                    if viewModel.usersListFull == false {
                        ActivityIndicatorView(isAnimating: .constant(true), style: .large)
                            .onAppear {
                                self.viewModel.fetchUsers()
                            }
                    }
                }
            }
            .navigationBarTitle(Text("Users"))
        }
    }
}

struct ActivityIndicatorView: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicatorView>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
