//
//  UserRepoRow.swift
//  GithubUsers
//
//  Created by Jacek Dogiel on 19/04/2021.
//

import SwiftUI

struct UserRepoRow: View {
    @ObservedObject var viewModel: UserRepoViewModel
    @State var repo: Repo

    var body: some View {
        VStack(alignment: .leading) {

            Text("\(repo.name) (\(repo.full_name))")
                .font(Font.system(size: 18).bold())
                .minimumScaleFactor(0.5)
            Text("Created at \(repo.created_at)")
                .font(Font.system(size: 14))
            Text("Updated at \(repo.updated_at)")
                .font(Font.system(size: 14))

            Spacer()
            }
            .frame(height: 60)
    }
}
