//
//  InstagramRepository.swift
//  ExampleCollectionView
//
//  Created by Vu Duc Trong on 22/02/2023.
//

import Foundation

protocol InstagramRepository {

  func loadData() -> [ImageEntity]
  
}
