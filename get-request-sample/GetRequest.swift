//
//  GetRequest.swift
//  get-request-sample
//
//  Created by shun uematsu on 2023/07/01.
//

import SwiftUI

@propertyWrapper
struct Get<Value>: DynamicProperty where Value: Decodable, Value: Equatable {
  var wrappedValue: LoadState<Value> { loadState }

  @State private var loadState: LoadState<Value> = .loading()
  private let keyPath: KeyPath<EndpointValues, Value>
  private let defaultValue: Value?

  init(
    _ keyPath: KeyPath<EndpointValues, Value>,
    _ defaultValue: Value? = nil
  ) {
    self.keyPath = keyPath
    self.defaultValue = defaultValue
    if let defaultValue = defaultValue {
      _loadState = .init(initialValue: .loading(skelton: defaultValue))
    }
  }
}

extension Get {
  struct EndpointValues {
    /// /v1/users
    @Lateinit var users: [User]
    /// /v1/songs
    @Lateinit var songs: [Song]
  }
}

extension Get {
  /// /v1/songs
  func requestSongs(songDataSource: SongDataSource = .mock) async {
    do {
      try! await Task.sleep(nanoseconds: 1_000_000_000)
      let response = try await songDataSource.fetchSongs()
      var endpointValue = EndpointValues()
      endpointValue.songs = response
      loadState = .success(endpointValue[keyPath: keyPath])
    } catch {
      loadState = .failure(.init(errorDescription: error.localizedDescription))
    }
  }
  
  /// /v1/users
  func requestUsers(userDataSource: UserDataSource = .mock) async {
    do {
      try! await Task.sleep(nanoseconds: 1_000_000_000)
      let response = try await userDataSource.fetchUsers()
      var endpointValue = EndpointValues()
      endpointValue.users = response
      loadState = .success(endpointValue[keyPath: keyPath])
    } catch {
      loadState = .failure(.init(errorDescription: error.localizedDescription))
    }
  }
}
