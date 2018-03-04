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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
    
    func getData() {
        APIManager.shared.getResponse(urlString: "https://www.californiapsychics.com/psychics?format=json", params: [:]) { (error) in
            if error == nil {
                self.collectionView.reloadData()
            } else {
                self.showAlert(message: "Failed to fetch ISS details. Go back and try again")
            }
        }
    }
}

