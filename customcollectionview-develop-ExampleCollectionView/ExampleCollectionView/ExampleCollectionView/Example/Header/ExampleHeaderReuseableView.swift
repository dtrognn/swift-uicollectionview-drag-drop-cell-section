//
//  HeaderReuseableView.swift
//  ExampleCollectionView
//
//  Created by Vu Duc Trong on 21/02/2023.
//

import UIKit

class ExampleHeaderReuseableView: UICollectionReusableView {

  @IBOutlet weak private var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

// MARK: - func bindData

extension ExampleHeaderReuseableView {

  func bindData(_ indexPath: IndexPath) {
    titleLabel.text = "Header \(indexPath)"
  }

}
