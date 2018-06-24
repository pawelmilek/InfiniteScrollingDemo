//
//  WebServiceResource.swift
//  InfiniteScrollingDemo
//
//  Created by Pawel Milek on 24/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

struct WebServiceResource<M> where M: Decodable {
  let url: URL
  
  var parseJSON: (Data) -> WebServiceResultType<M, WebServiceError> = { data in
    if let decodedModel = try? JSONDecoder().decode(M.self, from: data) {
      return .success(decodedModel)
    } else {
      return .failure(WebServiceError.decodeFailed)
    }
  }
  
  init(url: URL) {
    self.url = url
  }
}
