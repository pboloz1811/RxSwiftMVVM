//
//  GitHub.swift
//  RxGitHubSearch
//
//  Created by Patryk on 04.03.2017.
//  Copyright © 2017 Patryk. All rights reserved.
//

import Foundation
import ObjectMapper




class GitHub: Mappable{
    
    var name = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["full_name"]
    }
    
}
