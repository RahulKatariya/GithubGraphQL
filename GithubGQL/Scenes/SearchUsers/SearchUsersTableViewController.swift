//
//  SearchUsersTableViewController.swift
//  GithubGQL
//
//  Created by Rahul Katariya on 09/06/18.
//  Copyright © 2018 RahulKatariya. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import ReactorKit
import Kingfisher

class SearchUsersTableViewController: UITableViewController, StoryboardView {
    
    struct Constants {
        static let cellIdentifier = "Cell"
    }
    
    // Rx
    var disposeBag = DisposeBag()
    
    // UI
    let searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.dimsBackgroundDuringPresentation = false
        return sc
    }()
    
    /// MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.dataSource = nil
        tableView.delegate = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do additional work here.
        navigationItem.searchController = searchController
    }
    
    func bind(reactor: SearchUsersReactor) {
        
        // Clear table view when the search has dismissed
        searchController.rx.didDismiss
            .map { Reactor.Action.setQuery(nil) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.text
            .throttle(0.3, scheduler: MainScheduler.instance)
            .map { Reactor.Action.setQuery($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        tableView.rx.willDisplayCell
            .subscribe(onNext: { cell, indexPath in
                let user = reactor.currentState.users[indexPath.row]
                if let avatarUrl = user.avatarUrl,
                    let url = URL(string: avatarUrl) {
                    cell.imageView?.kf.setImage(with: url)
                }
            })
            .disposed(by: disposeBag)
        
        // Cancel Image Download Task if cell has disappeared to free up resources.
        tableView.rx.didEndDisplayingCell
            .subscribe(onNext: { cell, indexPath in
                cell.imageView?.kf.cancelDownloadTask()
            })
            .disposed(by: disposeBag)

        reactor.state.map { $0.users }
            .bind(to: tableView.rx.items(cellIdentifier: Constants.cellIdentifier)) { index, user, cell in
                cell.textLabel?.text = user.name
            }
            .disposed(by: disposeBag)
    }
    
}
