//
//  ConfigAlert.swift
//  ExampleCollectionView
//
//  Created by Vu Duc Trong on 24/02/2023.
//

import UIKit

extension ExampleViewController {
  
  func presentAlert(withTitle title: String,
                    message: String,
                    actionTitle: String, style: UIAlertAction.Style)
  {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

    let action = UIAlertAction(title: actionTitle, style: style)
    alertController.addAction(action)

    self.present(alertController, animated: true, completion: nil)
  }
}
