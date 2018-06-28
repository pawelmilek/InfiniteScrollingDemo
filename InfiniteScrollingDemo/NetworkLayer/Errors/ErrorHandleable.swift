//
//  ErrorHandleable.swift
//  InfiniteScrollingDemo
//
//  Created by Pawel Milek on 16/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.//

import Foundation

protocol ErrorHandleable: Error, CustomStringConvertible { }


// MARK: - Handle errors
extension ErrorHandleable {
  
  func handle() {
    DispatchQueue.main.async {
      AlertViewPresenter.shared.presentError(withMessage: self.description)
    }
  }
  
}
