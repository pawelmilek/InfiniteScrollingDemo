//
//  ActivityIndicator.swift
//  InfiniteScrollingDemo
//
//  Created by Pawel Milek on 16/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation
import UIKit

final class ActivityIndicator {
  static let shared = ActivityIndicator()
  
  private lazy var activityIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    indicator.hidesWhenStopped = true
    return indicator
  }()
  
  private lazy var loadingView: UIView = {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    view.clipsToBounds = true
    view.layer.cornerRadius = 10
    return view
  }()
  
  private var container = UIView()
  
  private init() {}
}


// MARK: - Start/Stop indicator
extension ActivityIndicator {
  
  func startAnimating(at view: UIView) {
    container.backgroundColor = UIColor.black.withAlphaComponent(0.2)
    loadingView.addSubview(activityIndicator)
    container.addSubview(loadingView)
    view.addSubview(container)
    
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
    activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
    activityIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
    activityIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    loadingView.translatesAutoresizingMaskIntoConstraints = false
    loadingView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
    loadingView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
    loadingView.widthAnchor.constraint(equalToConstant: 80).isActive = true
    loadingView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    
    container.translatesAutoresizingMaskIntoConstraints = false
    container.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    container.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    container.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    container.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    
    activityIndicator.startAnimating()
  }
  
  
  func stopAnimating() {
    DispatchQueue.main.async {
      self.activityIndicator.stopAnimating()
      self.container.removeFromSuperview()
    }
  }
  
}
