//
//  Thumbnail.swift
//  InfiniteScrollingDemo
//
//  Created by Pawel Milek on 18/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

struct Thumbnail {
  let url: String
  let width: Int
  let height: Int
}


// MARK: - Decodable protocol
extension Thumbnail: Decodable {
  
  enum CodingKeys: String, CodingKey {
    case url
    case width
    case height
  }
  
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.url = try container.decode(String.self, forKey: .url)
    self.width = try container.decode(Int.self, forKey: .width)
    self.height = try container.decode(Int.self, forKey: .height)
  }
  
}
