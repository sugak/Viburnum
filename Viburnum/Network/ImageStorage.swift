//
//  ImageStorage.swift
//  Viburnum
//
//  Created by Maksim Sugak on 14/04/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation

struct ProfileImage: Codable {
  
  var webformatURL: String = ""
  
//  enum CodingKeys: String, CodingKey {
//    case imageURL = "webformatURL"
//  }
  
//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//    webformatURL = try values.decode(String.self, forKey: .webformatURL)
//  }
}

//struct ImagesDataStore: Codable {
//  var images: [ProfileImage]
//}
