//
//  ConfigActions.swift
//  ExampleCollectionView
//
//  Created by Vu Duc Trong on 24/02/2023.
//

import UIKit

// MARK: - handleLongPressGesture ExampleViewController

extension ExampleViewController {
  func configDragDropGesture() {
    let dragDropGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleDragDropGesture))
    collectionView.addGestureRecognizer(dragDropGesture)
  }

  @objc private func handleDragDropGesture(_ gesture: UILongPressGestureRecognizer) {
    let gestureLocation = gesture.location(in: collectionView)

    switch gesture.state {
    case .began:
      guard let targetIndexPath = collectionView.indexPathForItem(at: gestureLocation) else {
        return
      }
      collectionView.beginInteractiveMovementForItem(at: targetIndexPath)

    case .changed:
      collectionView.updateInteractiveMovementTargetPosition(gestureLocation)

    case .ended:
      collectionView.endInteractiveMovement()

    default:
      collectionView.cancelInteractiveMovement()
    }
  }
}

// MARK: - handleDoubleTapGesture ExampleViewController

extension ExampleViewController {
  func configDoubleTapGesture() {
    let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapGesture))
    doubleTapGesture.numberOfTapsRequired = 2
    doubleTapGesture.delaysTouchesBegan = true
    collectionView.addGestureRecognizer(doubleTapGesture)
  }

  @objc private func handleDoubleTapGesture(_ gesture: UITapGestureRecognizer) {
    let gestureLocation = gesture.location(in: collectionView)
    guard let selectedIndexPath = collectionView.indexPathForItem(at: gestureLocation) else {
      return
    }

    presentAlert(withTitle: "Double Taps",
                 message: "You double tapped at index \(selectedIndexPath.row)",
                 actionTitle: "CANCEL",
                 style: .cancel)
  }
}

// MARK: - configLongTapGesture ExampleViewController

extension ExampleViewController {
  func configLongTapGesture() {
    let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongTapGesture))

    longTapGesture.minimumPressDuration = 3
    longTapGesture.delaysTouchesBegan = true

    collectionView.addGestureRecognizer(longTapGesture)
  }

  @objc private func handleLongTapGesture(_ gesture: UILongPressGestureRecognizer) {
    if gesture.state != .began {
      return
    }

    let gestureLocation = gesture.location(in: collectionView)

    guard let selectedIndexPath = collectionView.indexPathForItem(at: gestureLocation) else {
      return
    }

    presentAlert(withTitle: "Long Tap",
                 message: "You long tapped at index \(selectedIndexPath.row)",
                 actionTitle: "DESTRUCTIVE",
                 style: .destructive)
  }
}
