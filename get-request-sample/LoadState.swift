//
//  LoadState.swift
//  get-request-sample
//
//  Created by shun uematsu on 2023/07/01.
//

import Foundation

public struct LoadingError: LocalizedError, Equatable {
  public var errorDescription: String?
  public var failureReason: String?
  public var recoverySuggestion: String?

  public init(
    errorDescription: String,
    failureReason: String? = nil,
    recoverySuggestion: String? = nil
  ) {
    self.errorDescription = errorDescription
    self.failureReason = failureReason
    self.recoverySuggestion = recoverySuggestion
  }
}

public enum LoadState<Value: Equatable>: Equatable {
  case loading(skelton: Value? = nil)
  case success(Value)
  case failure(LoadingError)
}
