//
//  AlbumTableViewController.swift
//  Coding Challenge
//
//  Created by John Lawrence Figuerres on 11/9/22.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class AlbumTableViewController: UITableViewController {
    
    weak var albumViewModel: AlbumViewModel?
    weak var coordinator: MainCoordinator?
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refresh()
    }
    
    func bindViewModel() {
        albumViewModel?
            .albumList
            .bind(to:tableView.rx.items(
                cellIdentifier: AlbumTableViewCell.typeName,
                cellType: AlbumTableViewCell.self)) {
                    (_, model: AlbumWithUser, cell: AlbumTableViewCell) in
                    cell.accessoryType = .disclosureIndicator
                    cell.tittleLabel.text = model.album.title
                    cell.nameLabel.text = model.user?.name
                }.disposed(by: disposeBag)
        
        albumViewModel?
            .isLoading
            .subscribe(onNext: {[weak self] isLoading in
            
                if isLoading {
                    if let isRefreshing = self?.refreshControl?.isRefreshing,
                        !isRefreshing {
                        ProgressHUD.show()
                    }
            } else {
                ProgressHUD.dismiss()
                self?.refreshControl?.endRefreshing()
                
            }
        
        }).disposed(by: disposeBag)
        
        albumViewModel?
            .errorMessage
            .subscribe(onNext: { [weak self] errorMessage in
                self?.showError(errorMessage)
        }).disposed(by: disposeBag)
        
        
    }
    
    func setupTableView() {
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.register(UINib(nibName: AlbumTableViewCell.typeName, bundle: nil), forCellReuseIdentifier: AlbumTableViewCell.typeName)
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        tableView.addSubview(refreshControl!)
        
        tableView.rx.modelSelected(AlbumWithUser.self)
                 .subscribe(onNext: { [weak self] model in
                     self?.coordinator?.goToPhotoView(data: model)
                 }).disposed(by: disposeBag)
    }
    
    @objc func refresh() {
        albumViewModel?.fetchGetAlbumList()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}

