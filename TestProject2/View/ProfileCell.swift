//
//  ProfileCell.swift
//  TestProject2
//
//  Created by vamsi krishna reddy kamjula on 3/4/18.
//  Copyright © 2018 vamsi krishna reddy kamjula. All rights reserved.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var psychicNameLbl: UILabel!
    @IBOutlet weak var basePriceLbl: UILabel!
    @IBOutlet weak var skillsLbl: UILabel!
    @IBOutlet weak var specialitiesLbl: UILabel!
    
    override func prepareForReuse() {
        profileImgView.image = #imageLiteral(resourceName: "defaultProfileImg")
    }
    
    var name: String! {
        didSet {
            psychicNameLbl.text = name
        }
    }

    var price: String! {
        didSet {
            basePriceLbl.text = "$ \(price)0"
        }
    }

    var skills: String! {
        didSet {
            skillsLbl.text = skills
        }
    }
    
    var specialities: String! {
        didSet {
            specialitiesLbl.text = specialities
        }
    }
}
