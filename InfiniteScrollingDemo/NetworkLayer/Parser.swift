//
//  Parser.swift
//  InfiniteScrollingDemo
//
//  Created by Pawel Milek on 16/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

struct Parser<M> where M: Decodable {
  
  static func parseJSON(_ data: Data) -> WebServiceResultType<M, WebServiceError> {
    if let decodedModel = try? JSONDecoder().decode(M.self, from: data) {
      return .success(decodedModel)
    } else {
      return .failure(WebServiceError.decodeFailed)
    }
  }
}
