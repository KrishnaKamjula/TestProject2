//
//  DataParsing.swift
//  TestProject2
//
//  Created by vamsi krishna reddy kamjula on 3/4/18.
//  Copyright © 2018 vamsi krishna reddy kamjula. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ResponseData {
    public static let shared = ResponseData()
    var allPsychics = [Psychic]()
    
    public func fetchData(responseData: Data?) {
        let json = JSON(responseData as Any)
        let results = json["results"].arrayValue
        for psychic in results {
            guard let name = psychic["lineName"].string else {
                return
            }
            guard let price = psychic["basePrice"].double else {
                return
            }
            guard let skills = psychic["skills"].string else {
                return
            }
            guard let specialities = psychic["specialities"].string else {
                return
            }
            guard let images = psychic["images"].array else {
                return
            }
            
            let imageUrl = images[0].string
            
            let person = Psychic(psychicName: name, psychicBasePrice: price, psychicSkills: skills, psychicSpecialities: specialities, psychicImageUrl: imageUrl)
            
            self.allPsychics.append(person)
        }
    }
}
