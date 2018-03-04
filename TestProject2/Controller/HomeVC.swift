//
//  ViewController.swift
//  TestProject2
//
//  Created by vamsi krishna reddy kamjula on 3/4/18.
//  Copyright © 2018 vamsi krishna reddy kamjula. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var session: URLSession!
    
    var cache:NSCache<AnyObject, AnyObject>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        session = URLSession.shared
        self.cache = NSCache()
        
        getData()
    }
    
    func getData() {
        APIManager.shared.getResponse(urlString: "https://www.californiapsychics.com/psychics?format=json", params: [:]) { (error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } else {
                self.showAlert(message: "Failed to fetch ISS details. Go back and try again")
            }
        }
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ResponseData.shared.allPsychics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "psychicCell", for: indexPath) as? ProfileCell {
            
            let psychic = ResponseData.shared.allPsychics[indexPath.row]
            
            cell.name = psychic.psychicName
            cell.price = psychic.psychicBasePrice
            cell.skills = psychic.psychicSkills
            cell.specialities = psychic.psychicSpecialities
            
            if (self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil){
                cell.profileImgView.image = self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage
            }else{
                let artworkUrl = psychic.psychicImageUrl
                let url:URL! = URL(string: artworkUrl!)
                session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
                    if let data = try? Data(contentsOf: url){
                        DispatchQueue.main.async(execute: { () -> Void in
                            if let updateCell = self.collectionView.cellForItem(at: indexPath) as? ProfileCell {
                                let img:UIImage! = UIImage(data: data)
                                updateCell.profileImgView.image = img
                                self.cache.setObject(img, forKey: (indexPath as NSIndexPath).row as AnyObject)
                            }
                        })
                    }
                }).resume()
            }
 
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numOfColumns : CGFloat = 2
        let spaceBetweenCells : CGFloat = 5
        let padding : CGFloat = 5
        
        let cellWidth = ((collectionView.bounds.width - padding) - (numOfColumns - 1) * spaceBetweenCells) / numOfColumns
        return CGSize(width: cellWidth, height: collectionView.bounds.height / 2)
    }
}

