//
//  CellDequeueble.swift
//  InfiniteScrollingDemo
//
//  Created by Pawel Milek on 18/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

protocol CellDequeueble: class { }

extension CellDequeueble where Self: UITableView {
  
  func dequeueCell<T: UITableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
    let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    return cell
  }
  
}
