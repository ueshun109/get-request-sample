//
//  ContentView.swift
//  get-request-sample
//
//  Created by shun uematsu on 2023/07/01.
//

import SwiftUI

struct ContentView: View {
  @Get(\.users, .fakes) var users
  @Get(\.songs, .fakes) var songs

  var body: some View {
    Group {
      switch (users, songs) {
      case (.success(let users), .success(let songs)):
        List {
          usersSection(users)
          songsSection(songs)
        }
      case (.failure(let e), _), (_, .failure(let e)):
        error(e)
      case (.loading(let users), .loading(let songs)):
        Group {
          if let users, let songs {
            List {
              usersSection(users)
              songsSection(songs)
            }
          } else {
            ProgressView()
          }
        }
        .redacted(reason: .placeholder)
        .transition(.opacity)
        .disabled(true)
        .task {
          async let a: () = _users.requestUsers()
          async let b: () = _songs.requestSongs()
          _ = await (a, b)
        }
      default:
        EmptyView()
      }
    }
    .animation(.default, value: users)
    .animation(.default, value: songs)
  }

  func usersSection(_ users: [User]) -> some View {
    Section {
      ForEach(users) { user in
        HStack {
          Text(user.firstName)
          Text(user.lastName)
        }
      }
    } header: {
      Text("Users")
    }
  }

  func songsSection(_ songs: [Song]) -> some View {
    Section {
      ForEach(songs) { song in
        HStack {
          Text(song.title)
          Text(song.artist)
        }
      }
    } header: {
      Text("Songs")
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
