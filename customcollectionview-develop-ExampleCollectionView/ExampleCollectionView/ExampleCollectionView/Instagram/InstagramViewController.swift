//
//  InstagramViewController.swift
//  ExampleCollectionView
//
//  Created by Vu Duc Trong on 23/02/2023.
//

import SDWebImage
import UIKit

class InstagramViewController: UIViewController {
  @IBOutlet private var instaCollectionView: UICollectionView!

  private lazy var instagramRepository: InstagramRepository = InstagramRepositoryImplement()
  
  private var models: [ImageEntity] = [] {
    didSet {
      instaCollectionView?.reloadData()
    }
  }

  private let numberOfItem: CGFloat = 3
  private let minimumLineSpacing: CGFloat = 1
  private let minimumInteritemSpacing: CGFloat = 1

  override func viewDidLoad() {
    super.viewDidLoad()

    configCollecctionView(instaCollectionView)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    models = instagramRepository.loadData()
  }
}

// MARK: - InstagramViewController

extension InstagramViewController {
  func configCollecctionView(_ collectionView: UICollectionView) {
    collectionView.register(
      UINib(nibName: "\(InstagramCell.self)", bundle: nil),
      forCellWithReuseIdentifier: "\(InstagramCell.self)")

    collectionView.delegate = self
    collectionView.dataSource = self
  }
}

// MARK: - UICollectionViewDelegate

extension InstagramViewController: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource

extension InstagramViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int
  {
    return models.count
  }

  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
  {
    let instaCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(InstagramCell.self)", for: indexPath) as! InstagramCell

    let cells = models[indexPath.row]
    instaCell.binding(cells)

    return instaCell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension InstagramViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize
  {
    let widthCell = floor((view.frame.size.width - (numberOfItem - minimumInteritemSpacing)) / numberOfItem)
    let heightCell = widthCell

    return CGSize(width: widthCell, height: heightCell)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat
  {
    return minimumLineSpacing
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
  {
    return minimumInteritemSpacing
  }
}
