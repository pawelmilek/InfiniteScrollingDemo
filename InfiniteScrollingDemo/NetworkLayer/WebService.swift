//
//  WebService.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation
import UIKit

struct WebService {
  static let shared = WebService()
  private let baseURL = "https://www.googleapis.com/youtube/v3/"
  private let endpoint = "channels"
  private let resourceUrl = ""
  
//  typealias RestaurantRequestCompletion = (WebServiceResultType<RestaurantResponse, WebServiceError>) -> ()
  
  private init() {}
}


//// MARK: - Request restaurants data
//extension WebService {
//
//  func requestRestaurantsData(completionHandler: @escaping RestaurantRequestCompletion) {
//    guard let url = URL(string: resourceUrl) else {
//      let error = WebServiceError.unknownURL(reason: "Fail to create URL: \(resourceUrl)")
//      completionHandler(.failure(error))
//      return
//    }
//
//    let urlRequest = URLRequest(url: url)
//    URLSession.shared.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
//      guard error == nil else {
//        completionHandler(.failure(WebServiceError.requestFailed))
//        return
//      }
//
//      guard let responseData = data else {
//        completionHandler(.failure(WebServiceError.dataNotAvailable))
//        return
//      }
//
//      do {   // TODO: extract
//        let restaurants = try JSONDecoder().decode(RestaurantResponse.self, from: responseData)
//        completionHandler(.success(restaurants))
//
//      } catch let error {
//        print(error)
//        completionHandler(.failure(WebServiceError.decodeFailed))
//      }
//    }).resume()
//  }
//
//}

