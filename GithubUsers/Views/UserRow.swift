//
//  UserRow.swift
//  GithubUsers
//
//  Created by Jacek Dogiel on 19/04/2021.
//

import SwiftUI

struct UserRow: View {
    @ObservedObject var viewModel: FetchUsersViewModel
    @State var user: User

    var body: some View {
        HStack {
            viewModel.userImages[user].map { image in
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 44, height: 44)
                    .clipShape(Rectangle())
                    .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
            }

            Text(user.login)
                .font(Font.system(size: 18).bold())

            Spacer()
            }
            .frame(height: 60)
    }
}
