//
//  Registrable.swift
//  InfiniteScrollingDemo
//
//  Created by Pawel Milek on 18/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

protocol Registrable: class {}

extension Registrable where Self: UITableView {
  
  func register<T: UITableViewCell>(cell: T.Type) {
    let nib = UINib(nibName: T.nibName, bundle: nil)
    register(nib, forCellReuseIdentifier: T.reuseIdentifier)
  }
  
}
