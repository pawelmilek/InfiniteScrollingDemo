//
//  Snippet.swift
//  InfiniteScrollingDemo
//
//  Created by Pawel Milek on 18/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

struct Snippet {
  let publishedAt: String
  let channelId: String
  let title: String
  let description: String
  let thumbnails: [String: Thumbnail]
  let channelTitle: String
}


// MARK: - Decodable protocol
extension Snippet: Decodable {
  
  enum CodingKeys: String, CodingKey {
    case publishedAt
    case channelId
    case title
    case description
    case thumbnails
    case channelTitle
  }
  
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.publishedAt = try container.decode(String.self, forKey: .publishedAt)
    self.channelId = try container.decode(String.self, forKey: .channelId)
    self.title = try container.decode(String.self, forKey: .title)
    self.description = try container.decode(String.self, forKey: .description)
    self.thumbnails = try container.decode([String: Thumbnail].self, forKey: .thumbnails)
    self.channelTitle = try container.decode(String.self, forKey: .channelTitle)
  }
  
}
