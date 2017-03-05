//
//  NetworkManager.swift
//  RxGitHubSearch
//
//  Created by Patryk on 04.03.2017.
//  Copyright © 2017 Patryk. All rights reserved.
//

import Foundation
import Moya


enum GitHubProvider {
    case getUsers(text:String)
}



extension GitHubProvider: TargetType {
    
    
    var baseURL: URL {return URL(string: "https://api.github.com")!}
    
    var path: String {
        switch self{
        case .getUsers(_):
            return "/search/repositories"
        default:
            break
        }
    }
    
    
    var method: Moya.Method {
        switch self {
        case .getUsers:
            return .get
        default:
            break
        }
    }
    
    
    var parameters: [String : Any]? {
        switch self {
        case .getUsers(let text):
            return ["q":text]
        default:
            break
        }
    }
    
    var task: Task {
        return .request
    }
    
    
    var sampleData: Data {
        return Data()
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
}
