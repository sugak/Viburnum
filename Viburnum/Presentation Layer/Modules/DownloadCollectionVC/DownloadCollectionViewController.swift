//
//  DownloadCollectionViewController.swift
//  Viburnum
//
//  Created by Maksim Sugak on 14/04/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import UIKit

class DownloadCollectionViewController: UIViewController {
  let itemsPerRow = 3
  let collectionViewSpace: CGFloat = 10
  private let loadURL = "https://pixabay.com/api/?key=12166192-4c9c421077c6998eccbae7630&q=portrait&image_type=photo&pretty=true&per_page=27"
  private var profileImages = [ProfileImage]()
  
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  @IBAction func backButton(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }

    override func viewDidLoad() {
        super.viewDidLoad()
      getLatestLoans()
      activityIndicator.isHidden = false
      activityIndicator.startAnimating()
    }
  
  func getLatestLoans() {
    guard let url = URL(string: loadURL) else {
      return
    }
    
    let request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
      
      if let error = error {
        print(response ?? "Null response")
        print(error)
        return
      }
      
      // Parse JSON data
      if let data = data {
        self.profileImages = self.parseJsonData(data: data)
        print(self.profileImages)
        
        OperationQueue.main.addOperation({
        self.collectionView.reloadData()
        })
      }
    })
    
    task.resume()
  }
  
  func parseJsonData(data: Data) -> [ProfileImage] {
    var profileImages = [ProfileImage]()
    
    do {
      let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
      
      let jsonImages = jsonResult?["hits"] as? [AnyObject]
      for json in jsonImages! {
        var profileImage = ProfileImage()
        profileImage.webformatURL = (json["webformatURL"] as? String)!
        profileImages.append(profileImage)
      }
    
    } catch {
      print(error)
    }
    return profileImages
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "backToProfile" {
      guard let indexPath = collectionView.indexPathsForSelectedItems?.first,
        let cell = collectionView.cellForItem(at: indexPath) as? DownloadCollectionCellCollectionViewCell,
        let profileVC = segue.destination as? ProfileViewController else { return }
      profileVC.photoImageView.image = cell.downloadedImageView.image
      profileVC.saveButtonsControl()
  }
}
}

extension DownloadCollectionViewController: UICollectionViewDelegate {
  
}

extension DownloadCollectionViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return profileImages.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell",
                                                        for: indexPath) as?
      DownloadCollectionCellCollectionViewCell else { return UICollectionViewCell() }
    
    DispatchQueue.main.async {
      cell.downloadedImageView.load(url: URL(string: self.profileImages[indexPath.row].webformatURL)!)
    }
    
    if indexPath.row == profileImages.count - 1 {
      activityIndicator.stopAnimating()
      activityIndicator.isHidden = true
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) as? DownloadCollectionCellCollectionViewCell else { return }
      performSegue(withIdentifier: "backToProfile", sender: cell.downloadedImageView.image)
  }
}

extension DownloadCollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let paddingSpace = collectionViewSpace * CGFloat(itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / CGFloat(itemsPerRow)
    return CGSize(width: widthPerItem, height: widthPerItem)
  }
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: collectionViewSpace, left: collectionViewSpace, bottom: collectionViewSpace, right: collectionViewSpace)
  }
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return collectionViewSpace
  }
}

extension UIImageView {
  func load(url: URL) {
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self?.image = image
          }
        }
      }
    }
  }
}
