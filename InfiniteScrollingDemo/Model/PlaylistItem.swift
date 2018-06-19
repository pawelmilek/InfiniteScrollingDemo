//
//  PlaylistItem.swift
//  InfiniteScrollingDemo
//
//  Created by Pawel Milek on 18/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

struct PlaylistItem {
  let id: String
  let snippet: Snippet
}

// MARK: - Decodable protocol
extension PlaylistItem: Decodable {
  
  enum CodingKeys: String, CodingKey {
    case id
    case snippet
  }
  
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(String.self, forKey: .id)
    self.snippet = try container.decode(Snippet.self, forKey: .snippet)
  }
  
}
