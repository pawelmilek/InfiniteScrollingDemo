//
//  YoutubePlaylistItemsRequest.swift
//  InfiniteScrollingDemo
//
//  Created by Pawel Milek on 16/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

struct YoutubePlaylistItemsRequest: WebServiceRequest {
  var path = "playlistItems"
  var parameters: Parameters
  
  private init(parameters: Parameters) {
    self.parameters = parameters
  }

}

// MARK: - Factory method
extension YoutubePlaylistItemsRequest {
  
  static func make(nextPage token: String? = nil) -> YoutubePlaylistItemsRequest {
    let APIKey = "AIzaSyCSByu8DZ-nh_1CHOrqZZLGpf5Go4qBOPM"
    let defaultParameters = ["part": "snippet", "maxResults": "25", "playlistId": "UUuP2vJ6kRutQBfRmdcI92mA", "key": "\(APIKey)"]
    
    var parameters = defaultParameters
    
    if let token = token {
      parameters = ["pageToken": "\(token)"].merging(defaultParameters, uniquingKeysWith: +)
    }
    
    return YoutubePlaylistItemsRequest(parameters: parameters)
  }
  
}
