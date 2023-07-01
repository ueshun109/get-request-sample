//
//  ContentView.swift
//  get-request-sample
//
//  Created by shun uematsu on 2023/07/01.
//

import SwiftUI

struct ContentView: View {
  @Get(\.users, .fakes) var users

  var body: some View {
    Group {
      switch users {
      case .success(let response):
        list(response)
      case .failure(let e):
        error(e)
      case .loading(let fake):
        Group {
          if let fake {
            list(fake)
              .redacted(reason: .placeholder)
              .transition(.opacity)
              .disabled(true)
          } else {
            ProgressView()
          }
        }
        .task {
          await _users.requestUsers()
        }
      }
    }
    .animation(.default, value: users)
  }

  func list(_ users: [User]) -> some View {
    List {
      ForEach(users) { user in
        HStack {
          Text(user.firstName)
          Text(user.lastName)
        }
      }
    }
  }

  func error(_ loadingError: LoadingError) -> some View {
    Text(loadingError.errorDescription ?? "error default")
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
