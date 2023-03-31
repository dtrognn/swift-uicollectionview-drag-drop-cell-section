//
//  InstagramRepositoryImplement.swift
//  ExampleCollectionView
//
//  Created by Vu Duc Trong on 22/02/2023.
//

import Foundation

class InstagramRepositoryImplement: InstagramRepository {

  func loadData() -> [ImageEntity] {

    return ImageModel.dummyData()
    
  }

}
