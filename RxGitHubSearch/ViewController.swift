//
//  ViewController.swift
//  RxGitHubSearch
//
//  Created by Patryk on 04.03.2017.
//  Copyright © 2017 Patryk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = GitHubViewModel()
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "GitHubTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.viewModel.delegate = self
        self.tableView.dataSource = self
        searchBar.rx.text.orEmpty.debounce(0.3, scheduler: MainScheduler.instance).bindNext { (text:String) in
            self.viewModel.sendRxRequest(text: text)
        }.addDisposableTo(disposeBag)
        
    }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfElements()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! GitHubTableViewCell
        cell.confifureCell(dataSource: viewModel, indexPath: indexPath)
        return cell
    }
}


extension ViewController: TableViewReloadDataDelegate {
    func reloadTableViewData() {
        self.tableView.reloadData()
    }
}



