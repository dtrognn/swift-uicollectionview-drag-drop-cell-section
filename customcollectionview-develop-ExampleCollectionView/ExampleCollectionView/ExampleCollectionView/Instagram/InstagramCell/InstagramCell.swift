//
//  InstaCell.swift
//  ExampleCollectionView
//
//  Created by Vu Duc Trong on 23/02/2023.
//

import UIKit
import SDWebImage

class InstagramCell: UICollectionViewCell {

  @IBOutlet private weak var instaImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension InstagramCell {

  func binding(_ image: ImageEntity) {

    instaImageView.sd_setImage(
      with: URL(string: image.imageUrl)!,
      placeholderImage: UIImage(named: "placeholder.png"))
    
  }

}
