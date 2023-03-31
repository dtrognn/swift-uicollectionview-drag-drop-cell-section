//
//  ImageGridModel+Dummy.swift
//  ExampleCollectionView
//
//  Created by Vu Duc Trong on 22/02/2023.
//

import UIKit
import SDWebImage

extension ImageModel {

  static func dummyData() -> [ImageEntity] {

    return [
      "https://preview.redd.it/psbattle-a-fat-cat-in-a-box-v0-j2iibtnvflv91.jpg?auto=webp&s=02966b599957267f3ea9e41fc69861c2cab64c1c",
      "https://www.indianaconnection.org/wp-content/uploads/2022/08/GettyImages-927768566-WEB.jpg",
      "https://static.scientificamerican.com/sciam/cache/file/7A715AD8-449D-4B5A-ABA2C5D92D9B5A21_source.png",
      "https://media.audubon.org/styles/article_hero_inline/s3/tufted_titmouse._photo_deborah_bifulco_great_backyard_bird_count.jpg?itok=3_ydkTV-",
      "https://ichef.bbci.co.uk/news/640/cpsprodpb/4FB7/production/_116970402_a20-20sahas20barve20-20parrotbill_chavan.jpg",
      "https://www.forestandbird.org.nz/sites/default/files/styles/ratio_3_x_2_small_/public/2021-09/Ruru%20%28cropped%29%20-%20Credit%20-%20Maddox%20photography.jpg?itok=Tr-KBp15",
      "https://www.birdsandblooms.com/wp-content/uploads/2021/07/252705471_1_Trisha_Snider_BNB_BYPC2020.jpg",
      "https://www.arkwildlife.co.uk/wp-content/uploads/2022/07/male-red-bullfinch-bird.jpg",
      "https://www.mrsc.vic.gov.au/files/assets/public/council/news/bird.jpg?w=1200",
      "https://i.guim.co.uk/img/media/0402a5e22d80dfa64274c4cb0a56f497b0f482b9/0_17_5400_3239/master/5400.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=3dff37fbaef8ec431f66f6ffcd1b331c",
      "https://cdn.download.ams.birds.cornell.edu/api/v1/asset/171633971/1200",
      "https://www.indianaconnection.org/wp-content/uploads/2022/08/GettyImages-927768566-WEB.jpg",
      "https://www.birdlife.org/wp-content/uploads/2020/11/kingfisher-perched.jpg",
      "https://hakaimagazine.com/wp-content/uploads/header-gulf-birds.jpg",
      "https://explorenarrabriregion.com.au/wp-content/uploads/2022/10/Narrabri-Bird-Routes-1.jpg",
      "https://www.birdingplaces.eu/storage/files/large/_N711864-2.jpg",
      "https://cdn.download.ams.birds.cornell.edu/api/v1/asset/205226301/1200",
      "https://worldbirds.com/wp-content/uploads/2020/04/bluebird3.jpg",
      "https://cdn.birdwatchingdaily.com/2020/06/Mountain-Bluebird-nr-Millarville-29-May-2020-660x479.jpg",
      "https://www.birds.cornell.edu/home/wp-content/uploads/2019/02/mountain-bluebird-eric-gofreed-arizona-85631521-1280.jpg",
      "https://live-production.wcms.abc-cdn.net.au/62b22fb9fcb651b67aabff4e96d5e6f2?impolicy=wcms_crop_resize&cropH=1368&cropW=2429&xPos=13&yPos=97&width=862&height=485",
      "https://c.ndtvimg.com/environment-day-generic_625x300_1528170066781.jpg",
      "https://cdn.corporate.walmart.com/dims4/WMT/f7a8313/2147483647/strip/true/crop/1920x1080+0+0/resize/1200x675!/quality/90/?url=https%3A%2F%2Fcdn.corporate.walmart.com%2F7b%2F66%2F142c151b4cd3a19c13e1ca65f193%2Fbusinessfornature-banner.png",
      "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
      "https://www.bsr.org/images/heroes/bsr-focus-nature-hero.jpg",
      "https://images.unsplash.com/photo-1618588507085-c79565432917?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmVhdXRpZnVsJTIwbmF0dXJlfGVufDB8fDB8fA%3D%3D&w=1000&q=80"]
      .enumerated().map { (index, value) in
        ImageModel(id: "\(index)", imageUrl: value)
    }

  }

}
