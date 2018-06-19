//
//  PageInfo.swift
//  InfiniteScrollingDemo
//
//  Created by Pawel Milek on 18/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

struct PageInfo {
  let totalResults: Int
  let resultsPerPage: Int
}

// MARK: - Decodable protocol
extension PageInfo: Decodable {
  
  enum CodingKeys: String, CodingKey {
    case totalResults
    case resultsPerPage
  }
  
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.totalResults = try container.decode(Int.self, forKey: .totalResults)
    self.resultsPerPage = try container.decode(Int.self, forKey: .resultsPerPage)
  }
  
}
