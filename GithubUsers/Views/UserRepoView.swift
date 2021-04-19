//
//  UserRepoView.swift
//  GithubUsers
//
//  Created by Jacek Dogiel on 19/04/2021.
//

import SwiftUI

struct UserRepoView: View {
    @ObservedObject var viewModel = UserRepoViewModel()
    @State var url : URL!
    @State var pageURL : URL!
    @State var login : String!
    
    var body: some View {
        
        
        List(viewModel.repos) { repo in
            
            UserRepoRow(viewModel: self.viewModel, repo: repo).onTapGesture {
                UIApplication.shared.open(pageURL)
            }
            
        }.onAppear { self.viewModel.fetchUserRepos(for: url) }
        
        .navigationBarTitle(Text("\(login) repos"))
        
    }
}
