//
//  DownloadCollectionCellCollectionViewCell.swift
//  Viburnum
//
//  Created by Maksim Sugak on 14/04/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import UIKit

class DownloadCollectionCellCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet var profileImage: UIImageView!
  
  func displayContent(image: UIImage) {
    profileImage.image = image
  }
    
}
