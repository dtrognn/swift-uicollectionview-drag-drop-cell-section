//
//  ViewController.swift
//  ExampleCollectionView
//
//  Created by Vu Duc Trong on 21/02/2023.
//

import UIKit

enum DragDropType {
  case dragCell(number: Int)
  case placeholder
}

class ExampleViewController: UIViewController {
  @IBOutlet var collectionView: UICollectionView!

  private let minimumLineSpacing: CGFloat = 1
  private let minimumInteritemSpacing: CGFloat = 1
  private let numberOfItemInRow: CGFloat = 3

  private lazy var numbers: [[DragDropType]] = [
    [Int](1...3),
    [Int](4...6),
    [Int](7...9),
  ].map { $0.map { DragDropType.dragCell(number: $0) }}

  override func viewDidLoad() {
    super.viewDidLoad()

    configCollectionView(collectionView)
    print(numbers)

    // uncomment to avoid conflict with Long Tap handler
//    configDragDropGesture()

    configDoubleTapGesture()

    configLongTapGesture()
  }
}

// MARK: - configCollectionView ExampleViewController

extension ExampleViewController {
  func configCollectionView(_ collectionView: UICollectionView) {
    collectionView.register(
      .init(nibName: "\(ExampleCell.self)", bundle: nil),
      forCellWithReuseIdentifier: "\(ExampleCell.self)")

    collectionView.register(
      .init(nibName: "\(ExampleHeaderReuseableView.self)", bundle: nil),
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: "\(ExampleHeaderReuseableView.self)")

    collectionView.register(
      .init(nibName: "\(ExampleFooterReusableView.self)", bundle: nil),
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
      withReuseIdentifier: "\(ExampleFooterReusableView.self)")

    collectionView.delegate = self
    collectionView.dataSource = self

    collectionView.dragDelegate = self
    collectionView.dropDelegate = self

    collectionView.dragInteractionEnabled = true
  }
}

// MARK: - UICollectionViewDragDelegate

extension ExampleViewController: UICollectionViewDragDelegate {
  func collectionView(_ collectionView: UICollectionView,
                      itemsForBeginning session: UIDragSession,
                      at indexPath: IndexPath) -> [UIDragItem]
  {
    let itemProvider = NSItemProvider(object: "\(indexPath)" as NSString)
    let dragItem = UIDragItem(itemProvider: itemProvider)
    dragItem.localObject = numbers[indexPath.section][indexPath.item]
    return [dragItem]
  }

  // reference: https://stackoverflow.com/questions/39080807/drag-and-reorder-uicollectionview-with-sections
  func collectionView(_ collectionView: UICollectionView,
                      dragSessionWillBegin session: UIDragSession)
  {
    var itemsToInsert = [IndexPath]()
    (0 ..< numbers.count).forEach { index in
      if numbers[index].isEmpty {
        itemsToInsert.append(IndexPath(item: numbers[index].count, section: index))
        numbers[index].append(.placeholder)
      }
    }
    collectionView.insertItems(at: itemsToInsert)
  }

  func collectionView(_ collectionView: UICollectionView,
                      dragSessionDidEnd session: UIDragSession)
  {
    var removeItems = [IndexPath]()
    for section in 0 ..< numbers.count {
      for item in 0 ..< numbers[section].count {
        switch numbers[section][item] {
        case .placeholder:
          removeItems.append(IndexPath(item: item, section: section))
        case .dragCell:
          break
        }
      }
    }
    removeItems.forEach { indexPath in
      numbers[indexPath.section].remove(at: indexPath.item)
    }
    collectionView.deleteItems(at: removeItems)
  }
}

// MARK: - UICollectionViewDropDelegate

extension ExampleViewController: UICollectionViewDropDelegate {
  func collectionView(_ collectionView: UICollectionView,
                      canHandle session: UIDropSession) -> Bool
  {
    print(Self.self, #function)
    return true
  }

  func collectionView(_ collectionView: UICollectionView,
                      dropSessionDidUpdate session: UIDropSession,
                      withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal
  {
    if collectionView.hasActiveDrag {
      return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    } else {
      return UICollectionViewDropProposal(operation: .forbidden)
    }
  }

  func collectionView(_ collectionView: UICollectionView,
                      performDropWith coordinator: UICollectionViewDropCoordinator)
  {
    if let destinationIndexPath = coordinator.destinationIndexPath {
      reOrderItems(collectionView: collectionView,
                   coordinator: coordinator,
                   destinationIndexPath: destinationIndexPath)
    }
  }
}

// MARK: - ExampleViewController reOrderItems

extension ExampleViewController {
  private func reOrderItems(collectionView: UICollectionView,
                            coordinator: UICollectionViewDropCoordinator,
                            destinationIndexPath: IndexPath)
  {
    let items = coordinator.items
    if let item = items.first,
       let sourceIndexPath = item.sourceIndexPath,
       let localObject = item.dragItem.localObject as? DragDropType
    {
      collectionView.performBatchUpdates({
        numbers[sourceIndexPath.section].remove(at: sourceIndexPath.item)
        numbers[destinationIndexPath.section].insert(localObject, at: destinationIndexPath.item)
        collectionView.deleteItems(at: [sourceIndexPath])
        collectionView.insertItems(at: [destinationIndexPath])
      })
    }
  }
}

// MARK: - UICollectionViewDelegate

extension ExampleViewController: UICollectionViewDelegate {
  // Handle Tap Action
  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath)
  {
    presentAlert(withTitle: "Single Tap",
                 message: "You tapped at index: \(indexPath.row)",
                 actionTitle: "OK",
                 style: .default)
  }

  // Handle Header - Footer

  func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionReusableView
  {
    switch kind {
    case UICollectionView.elementKindSectionHeader:

      if let headerView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: "\(ExampleHeaderReuseableView.self)",
        for: indexPath) as? ExampleHeaderReuseableView
      {
        headerView.backgroundColor = .magenta
        headerView.bindData(indexPath)

        return headerView
      }

    case UICollectionView.elementKindSectionFooter:

      if let footerView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: "\(ExampleFooterReusableView.self)",
        for: indexPath) as? ExampleFooterReusableView
      {
        footerView.backgroundColor = .cyan
        footerView.bindData(indexPath)

        return footerView
      }

    default:
      return UICollectionReusableView()
    }

    return UICollectionReusableView()
  }
}

// MARK: - UICollectionViewDataSource

extension ExampleViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
    print(Self.self, #function)
    return true
  }

  func collectionView(_ collectionView: UICollectionView,
                      moveItemAt sourceIndexPath: IndexPath,
                      to destinationIndexPath: IndexPath)
  {
    let item = numbers.remove(at: sourceIndexPath.row)
    numbers.insert(item, at: destinationIndexPath.row)
    print(Self.self, #function)
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return numbers.count
  }

  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int
  {
    return numbers[section].count
  }

  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
  {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ExampleCell.self)",
                                                  for: indexPath) as! ExampleCell

    cell.bindData(numbers[indexPath.section][indexPath.row])

    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ExampleViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let widthContainer = view.frame.size.width
    let widthCell = floor(widthContainer - (numberOfItemInRow - 1) * minimumLineSpacing) / numberOfItemInRow
    let heightCell = widthCell

    return CGSize(width: widthCell, height: heightCell)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return minimumLineSpacing
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return minimumInteritemSpacing
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets.zero
  }
}
