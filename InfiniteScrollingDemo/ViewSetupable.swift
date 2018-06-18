//
//  ViewSetupable.swift
//  InfiniteScrollingDemo
//
//  Created by Pawel Milek on 18/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

@objc protocol ViewSetupable: class {
  func setup()
  @objc optional func setupStyle()
  @objc optional func setupLayout()
}
