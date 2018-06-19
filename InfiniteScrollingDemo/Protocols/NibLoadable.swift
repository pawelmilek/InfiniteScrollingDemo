//
//  CellDequeueble.swift
//  InfiniteScrollingDemo
//
//  Created by Pawel Milek on 18/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

protocol NibLoadable: class {}

// MARK: - Nib Name
extension NibLoadable where Self: UIView {
  
  static var nibName: String {
    return String(describing: self)
  }
  
}
