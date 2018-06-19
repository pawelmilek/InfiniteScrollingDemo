//
//  ViewController.swift
//  InfiniteScrollingDemo
//
//  Created by Pawel Milek on 16/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  private lazy var refreshController: UIRefreshControl = {
    let refreshCtr = UIRefreshControl()
    refreshCtr.tintColor = .black
    refreshCtr.addTarget(self, action: #selector(fetchData), for: .valueChanged)
    return refreshCtr
  }()
  
  private var isMoreDataLoading = false
  private var shouldShowActivityIndicatorOnce = true
  private var playlistItemsResponse: PlaylistItemsResponse?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    fetchData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupStyle()
  }
  
  
  @IBAction func moveToTopAndRefreshButtonTapped(_ sender: UIBarButtonItem) {
    tableView.setContentOffset(CGPoint(x: 0,  y: UIApplication.shared.statusBarFrame.height), animated: true)
    let indexPath = IndexPath(row: 0, section: 0)
    tableView.scrollToRow(at: indexPath, at: .top, animated: true)
  }
  
}


// MARK: - ViewSetupable protocol
extension ViewController: ViewSetupable {
  
  func setup() {
    setTableView()
  }
  
  func setupStyle() {
    setNavigationBar()
  }
  
}


// MARK: - Private - Set tableview
private extension ViewController {
  
  func setTableView() {
    setDelegate()
    setRendering()
    registerCustomCell()
    setRefreshController()
  }
  
}


// MARK: - Private - Set tableview
private extension ViewController {
  
  func setDelegate() {
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  func setRendering() {
    tableView.allowsSelection = false
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 260
    tableView.tableFooterView = UIView()
    tableView.backgroundColor = .lightGray
    tableView.separatorStyle = .none
  }
  
  func registerCustomCell() {
    tableView.register(cell: ThumbTableViewCell.self)
  }
  
  func setRefreshController() {
    tableView.refreshControl = refreshController
    tableView.alwaysBounceVertical = true
  }
  
}


// MARK: - Private - Set navigation bar
private extension ViewController {
  
  func setNavigationBar() {
    setTitle()
    setShadowUnderNavigationBar()
  }
  
}


// MARK: - Private - Set navigation bar
private extension ViewController {
  
  func setTitle() {
    let titleTextAttributed: [NSAttributedStringKey: Any] = [.foregroundColor: UIColor.black, .font: UIFont(name: "AvenirNext-Regular", size: 17)!]
    navigationController?.navigationBar.titleTextAttributes = titleTextAttributed
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.navigationBar.topItem?.title = "Infinite Scrolling"
  }
  
  func setShadowUnderNavigationBar() {
    navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
    navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 2, height: 2)
    navigationController?.navigationBar.layer.shadowRadius = 4
    navigationController?.navigationBar.layer.shadowOpacity = 1
  }
  
}


// MARK: - Private - Fetch data
private extension ViewController {
  
  @objc func fetchData() {
    showActivityIndicator()
    WebService.shared.requestVideosListData(completionHandler: {[weak self] result in
      guard let strongSelf = self else { return }
      
      switch result {
      case .success(let data):
        strongSelf.playlistItemsResponse = data
        strongSelf.reloadPlaylistItems()
        
      case .failure(let error):
        strongSelf.playlistItemsResponse = nil
        error.handle()
      }
      
      strongSelf.hideRefreshController()
      strongSelf.hideActivityIndicator()
      
      
    })
  }
  
  func fetchMoreData() {
    let nextPageToken = playlistItemsResponse?.nextPageToken
    WebService.shared.requestVideosListData(nextPageToken: nextPageToken, completionHandler: { [weak self] result in
      guard let strongSelf = self else { return }
      
      switch result {
      case .success(let data):
        strongSelf.playlistItemsResponse?.append(data)
        strongSelf.reloadPlaylistItems()
        
      case .failure(let error):
        strongSelf.playlistItemsResponse = nil
        error.handle()
      }
      
      strongSelf.isMoreDataLoading = false
    })
  }
  
}


// MARK: - Private - Reload/Refresh data
private extension ViewController {
  
  func reloadPlaylistItems() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  func hideRefreshController() {
    DispatchQueue.main.async {
      self.refreshController.endRefreshing()
    }
  }
  
  func showActivityIndicator() {
    if shouldShowActivityIndicatorOnce {
      ActivityIndicator.shared.startAnimating(at: view)
    }
  }
  
  func hideActivityIndicator() {
    if shouldShowActivityIndicatorOnce {
      ActivityIndicator.shared.stopAnimating()
      shouldShowActivityIndicatorOnce = false
    }
  }
}


// MARK: - UITableViewDataSource protocol
extension ViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return playlistItemsResponse?.items.count ?? 0
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let playlistItems = playlistItemsResponse?.items else { return UITableViewCell() }
    
    let cell = tableView.dequeueCell(cell: ThumbTableViewCell.self, for: indexPath)
    cell.configurate(by: playlistItems[indexPath.row])
    return cell
  }
  
}


// MARK: - UITableViewDelegate protocol
extension ViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let items = playlistItemsResponse?.items, isMoreDataLoading == false else { return }
    
    if (indexPath.row == items.count - 1) {
      let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
      spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
      spinner.startAnimating()
      tableView.tableFooterView = spinner
      tableView.tableFooterView?.isHidden = false
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
        self.isMoreDataLoading = true
        self.fetchMoreData()
      }
      
    } else {
      tableView.tableFooterView?.removeFromSuperview()
      let view = UIView()
      view.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(0))
      tableView.tableFooterView = view
      tableView.tableFooterView?.isHidden = true
    }
  }
  
}


// MARK: Actions
extension ViewController {
  
  
  
}
