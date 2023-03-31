//
//  FooterReusableView.swift
//  ExampleCollectionView
//
//  Created by Vu Duc Trong on 22/02/2023.
//

import UIKit

class ExampleFooterReusableView: UICollectionReusableView {

  @IBOutlet weak private var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

  // MARK: - func bindData

extension ExampleFooterReusableView {

  func bindData(_ indexPath: IndexPath) {
    titleLabel.text = "Footer \(indexPath)"
  }

}
