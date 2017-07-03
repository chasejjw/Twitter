//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    var name: String = ""
    var screenName: String = ""
    var profileBannerURL: String = ""
    var profileImageURL: String = ""
    var description: String = ""
    static var current: User?
    
    
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as? String ?? ""
        screenName = dictionary["screen_name"] as? String ?? ""
        profileBannerURL = dictionary["profile_banner_url"] as? String ?? ""
        profileImageURL = dictionary["profile_image_url_https"] as? String ?? ""
        description = dictionary["description"] as? String ?? ""
    }
}
