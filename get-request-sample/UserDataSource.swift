//
//  UserDataSource.swift
//  get-request-sample
//
//  Created by shun uematsu on 2023/07/01.
//

import Foundation

struct User: Decodable, Equatable, Identifiable {
  var id: String
  var firstName: String
  var lastName: String
}

extension [User] {
  static let fakes: [User] = [
    .init(id: "fake1", firstName: "fake", lastName: "fake"),
    .init(id: "fake2", firstName: "fake", lastName: "fake"),
    .init(id: "fake3", firstName: "fake", lastName: "fake"),
    .init(id: "fake4", firstName: "fake", lastName: "fake"),
    .init(id: "fake5", firstName: "fake", lastName: "fake"),
  ]
}

enum UserDataSource {
  case mock
  case failed

  func fetchUsers() async throws -> [User] {
    switch self {
    case .mock:
      return [
        .init(id: "1", firstName: "taro", lastName: "tanaka"),
        .init(id: "2", firstName: "ichiro", lastName: "suzuki"),
        .init(id: "3", firstName: "hanako", lastName: "sato"),
      ]
    case .failed:
      throw LoadingError(errorDescription: "error")
    }
  }
}
