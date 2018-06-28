//
//  WebServiceRequest.swift
//  InfiniteScrollingDemo
//
//  Created by Pawel Milek on 16/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

typealias Parameters = [String: String]

protocol WebServiceRequest {
  var path: String { get }
  var parameters: Parameters { get }
}
