//
//  GitHubViewModel.swift
//  RxGitHubSearch
//
//  Created by Patryk on 04.03.2017.
//  Copyright © 2017 Patryk. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import RxSwift
import RxCocoa

class GitHubViewModel {
    
    var model:Variable<[GitHub]>
    
    weak var delegate:TableViewReloadDataDelegate?
    
    let disposeBag = DisposeBag()
    
    init() {
        model = Variable([])
    }
    
    func sendRxRequest(text:String){
        if text != "" {
            let provider = RxMoyaProvider<GitHubProvider>()
            provider.request(.getUsers(text: text)).subscribe { [unowned self] (event) in
                switch event {
                case .next(let response):
                    let json = try? JSONSerialization.jsonObject(with: response.data) as! [String:Any]
                    self.model.value = Mapper<GitHub>().mapArray(JSONObject: json?["items"])!
                    self.delegate?.reloadTableViewData()
                case .error(let error):
                    print(error)
                case .completed:
                    print("Completed")
                }
                }.addDisposableTo(disposeBag)
        }else{
            model = Variable([])
            self.delegate?.reloadTableViewData()
        }
    }
    
    
    func getNumberOfElements() -> Int {
        return model.value.count
    }

}


extension GitHubViewModel:  GitHubTableViewCellDataSource {
    
    func getName(indexPath: IndexPath) -> Driver<String> {
        return model.asDriver().map{$0[indexPath.row].name}
    }
}

protocol TableViewReloadDataDelegate:class {
    func reloadTableViewData()
}



