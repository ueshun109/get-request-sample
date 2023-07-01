//
//  SongDataSource.swift
//  get-request-sample
//
//  Created by shun uematsu on 2023/07/01.
//

import Foundation

struct Song: Decodable, Equatable, Identifiable {
  var id: String
  var title: String
  var artist: String
}

extension [Song] {
  static let fakes: Self = [
    .init(id: "1", title: "Let it be", artist: "Beatles"),
    .init(id: "2", title: "Beat It", artist: "Michael Jackson"),
  ]
}

enum SongDataSource {
  case mock
  case failed

  func fetchSongs() async throws -> [Song] {
    switch self {
    case .mock:
      return [
        .init(id: "1", title: "Let it be", artist: "Beatles"),
        .init(id: "2", title: "Beat It", artist: "Michael Jackson"),
        .init(id: "3", title: "Beautiful Day", artist: "U2"),
      ]

    case .failed:
      throw LoadingError(errorDescription: "error")
    }
  }
}
