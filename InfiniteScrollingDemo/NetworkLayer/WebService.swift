//
//  WebService.swift
//  InfiniteScrollingDemo
//
//  Created by Pawel Milek on 16/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

struct WebService {
  static let shared = WebService()
  private let baseURL = "https://www.googleapis.com/youtube/v3/"
  private let APIKey = "AIzaSyCSByu8DZ-nh_1CHOrqZZLGpf5Go4qBOPM"
  
  typealias RequestCompletion = (WebServiceResultType<PlaylistItemsResponse, WebServiceError>) -> ()
  private init() {}
}


// MARK: - Request restaurants data
extension WebService {

  func requestVideosListData(nextPageToken: String? = nil, completionHandler: @escaping RequestCompletion) {
    var urlString: String = ""
    
    if let nextPageToken = nextPageToken {
      urlString = "\(baseURL)playlistItems?part=snippet&maxResults=25&pageToken=\(nextPageToken)&playlistId=UUuP2vJ6kRutQBfRmdcI92mA&key=\(APIKey)"
    } else {
      urlString = "\(baseURL)playlistItems?part=snippet&maxResults=25&playlistId=UUuP2vJ6kRutQBfRmdcI92mA&key=\(APIKey)"
    }
    
    guard let url = URL(string: urlString) else {
      let error = WebServiceError.unknownURL(reason: "Fail to create URL: \(urlString)")
      completionHandler(.failure(error))
      return
    }

    let urlRequest = URLRequest(url: url)
    URLSession.shared.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
      guard error == nil else {
        completionHandler(.failure(WebServiceError.requestFailed))
        return
      }

      guard let responseData = data else {
        completionHandler(.failure(WebServiceError.dataNotAvailable))
        return
      }

      do {
        let playlistItemsResponse = try JSONDecoder().decode(PlaylistItemsResponse.self, from: responseData)
        completionHandler(.success(playlistItemsResponse))

      } catch {
        completionHandler(.failure(WebServiceError.decodeFailed))
      }
    }).resume()
  }

}

