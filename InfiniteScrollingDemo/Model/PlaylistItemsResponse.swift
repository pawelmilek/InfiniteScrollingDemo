//
//  PlaylistItemsResponse.swift
//  InfiniteScrollingDemo
//
//  Created by Pawel Milek on 18/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

struct PlaylistItemsResponse {
  private(set) var nextPageToken: String
  private var prevPageToken: String?
  private let pageInfo: PageInfo
  private(set) var items: [PlaylistItem]
}

// MARK: - Append more data
extension PlaylistItemsResponse {
  
  mutating func append(_ playlistItems: PlaylistItemsResponse) {
    nextPageToken = playlistItems.nextPageToken
    prevPageToken = playlistItems.prevPageToken
    items.append(contentsOf: playlistItems.items)
  }
  
}


// MARK: - Decodable protocol
extension PlaylistItemsResponse: Decodable {
  
  enum CodingKeys: String, CodingKey {
    case nextPageToken
    case prevPageToken
    case pageInfo
    case items
  }
  
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.nextPageToken = try container.decode(String.self, forKey: .nextPageToken)
    self.prevPageToken = try container.decodeIfPresent(String.self, forKey: .prevPageToken)
    self.pageInfo = try container.decode(PageInfo.self, forKey: .pageInfo)
    self.items = try container.decode([PlaylistItem].self, forKey: .items)
  }
  
}
