//
//  Beer.swift
//  BrewDog
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 AC-iOS. All rights reserved.
//

import Foundation
class Beer {
    let name: String
    let tagline: String
    let abv: Double
    let beerDescription: String
    let imageURLString: String
    init(name: String, tagline: String, abv: Double, beerDescription: String, imageURLString: String) {
        self.name = name
        self.tagline = tagline
        self.abv = abv
        self.beerDescription = beerDescription
        self.imageURLString = imageURLString
    }
    convenience init?(from dict: [String:Any]) {
        guard let name = dict["name"] as? String,
        let tagline = dict["tagline"] as? String,
        let abv = dict["abv"] as? Double,
        let beerDescription = dict["description"] as? String,
        let imageURLString = dict["image_url"] as? String else {return nil}
        self.init(name: name, tagline: tagline, abv: abv, beerDescription: beerDescription, imageURLString: imageURLString)
    }
}


