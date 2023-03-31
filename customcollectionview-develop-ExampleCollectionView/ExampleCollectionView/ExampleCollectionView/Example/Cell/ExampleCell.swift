//
//  ExampleCell.swift
//  ExampleCollectionView
//
//  Created by Vu Duc Trong on 21/02/2023.
//

import UIKit

class ExampleCell: UICollectionViewCell {
  @IBOutlet private var titleLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
}

// MARK: - bindData

extension ExampleCell {
  func bindData(_ dragType: DragDropType) {
    switch dragType {
    case .dragCell(number: let number):
      titleLabel.text = "\(number)"
    case .placeholder:
      titleLabel.text = nil
    }
  }
}
