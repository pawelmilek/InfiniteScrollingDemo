//
//  ThumbTableViewCell.swift
//  InfiniteScrollingDemo
//
//  Created by Pawel Milek on 18/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

class ThumbTableViewCell: UITableViewCell {
  @IBOutlet weak var thumbImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  private var playlistItem: PlaylistItem? {
    didSet {
      guard let playlistItem = playlistItem else { return }
      let url = URL(string: (playlistItem.snippet.thumbnails["high"]?.url)!)
      
      thumbImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
      titleLabel.text = playlistItem.snippet.title
      descriptionLabel.text = playlistItem.snippet.description
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    thumbImageView.contentMode = .scaleAspectFill
    thumbImageView.clipsToBounds = true
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    thumbImageView.image = UIImage()
    titleLabel.text = ""
    descriptionLabel.text = ""
  }
  
}

// MARK: - Configurate items
extension ThumbTableViewCell {
  
  func configurate(by item: PlaylistItem) {
    self.playlistItem = item
  }
  
}
