//
//  GitHubTableViewCell.swift
//  RxGitHubSearch
//
//  Created by Patryk on 04.03.2017.
//  Copyright © 2017 Patryk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GitHubTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    
    var disposeBag = DisposeBag()
    func confifureCell(dataSource:GitHubTableViewCellDataSource, indexPath:IndexPath){
        dataSource.getName(indexPath: indexPath).drive(self.name.rx.text).addDisposableTo(disposeBag)
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
    
}


protocol GitHubTableViewCellDataSource:class {
    func getName(indexPath:IndexPath) -> Driver<String>
}
