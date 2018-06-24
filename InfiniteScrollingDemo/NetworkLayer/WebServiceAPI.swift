//
//  WebServiceAPI.swift
//  InfiniteScrollingDemo
//
//  Created by Pawel Milek on 16/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

final class WebServiceAPI {
  static let shared = WebServiceAPI()
  
  private let baseURL = "https://www.googleapis.com/youtube/v3/"
  private let APIKey = "AIzaSyCSByu8DZ-nh_1CHOrqZZLGpf5Go4qBOPM"
  
  var playlistItemsURL: URL {
    let urlString = "\(baseURL)playlistItems?part=snippet&maxResults=50&playlistId=UUuP2vJ6kRutQBfRmdcI92mA&key=\(APIKey)"
    return URL(string: urlString)!
  }
  
  func nextPagePlaylistItemsURL(at pageToken: String) -> URL {
    let urlString = "\(baseURL)playlistItems?part=snippet&maxResults=50&pageToken=\(pageToken)&playlistId=UUuP2vJ6kRutQBfRmdcI92mA&key=\(APIKey)"
    return URL(string: urlString)!
  }
  
  private init() {}
}


extension WebServiceAPI {
  
  func fetch<M>(resource: WebServiceResource<M>, completionHandler: @escaping (WebServiceResultType<M, WebServiceError>) -> ()) {
    URLSession.shared.dataTask(with: resource.url) { (data, _, error) in
      guard error == nil else {
        completionHandler(.failure(.requestFailed))
        return
      }
      
      guard let data = data else {
        completionHandler(.failure(.dataNotAvailable))
        return
      }
      
      completionHandler(resource.parseJSON(data))
      }.resume()
  }
}
