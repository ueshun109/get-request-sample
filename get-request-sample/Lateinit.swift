//
//  Lateinit.swift
//  get-request-sample
//
//  Created by shun uematsu on 2023/07/01.
//

import SwiftUI

@propertyWrapper
public struct Lateinit<Value>: DynamicProperty {
  private var value: Value?

  public init(value: Value? = nil) {
    self.value = value
  }

  public var wrappedValue: Value {
    get {
      guard let value = value else {
        fatalError("property accessed before being initialized")
      }
      return value
    }
    set {
      value = newValue
    }
  }
}
