//
//  WebServiceError.swift
//  InfiniteScrollingDemo
//
//  Created by Pawel Milek on 16/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

enum WebServiceError: ErrorHandleable {
  case unknownURL(reason: String)
  case requestFailed
  case dataNotAvailable
  case decodeFailed
}


// MARK: - ErrorHandleable protocol
extension WebServiceError {
  
  var description: String {
    switch self {
    case .unknownURL(reason: let reason):
      return reason
      
    case .requestFailed:
      return "Error JSON request failed"
      
    case .dataNotAvailable:
      return "Error data not available"
      
    case .decodeFailed:
      return "Error decoding JSON failed"
    }
  }
  
}
