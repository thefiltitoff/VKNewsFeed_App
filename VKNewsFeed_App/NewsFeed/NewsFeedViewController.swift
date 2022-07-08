//
//  NewsFeedViewController.swift
//  VKNewsFeed_App
//
//  Created by Феликс Титов on 7/5/22.
//  Copyright (c) 2022 . All rights reserved.
//

import UIKit

protocol NewsFeedDisplayLogic: AnyObject {
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic {
    
    var interactor: NewsFeedBusinessLogic?
    var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
    
    private var feedViewModel = FeedViewModel(cells: [], footerTitle: nil)
    private var titleView = TitleView()
    private lazy var footerView = FooterView()
    
    private var refreshControll: UIRefreshControl = {
        let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControll
    }()
    
    @IBOutlet weak var table: UITableView!
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = NewsFeedInteractor()
        let presenter             = NewsFeedPresenter()
        let router                = NewsFeedRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTopBars()
        
        setupTable()
        
        view.backgroundColor = .systemBackground
        interactor?.makeRequest(request: .getNewsFeed)
        interactor?.makeRequest(request: .getUser)
    }
    
    private func setupTable() {
        let topInset:CGFloat = 9
        table.contentInset.top = topInset
        table.register(UINib(nibName: "NewsFeedTableViewCell", bundle: nil), forCellReuseIdentifier: NewsFeedTableViewCell.reuseID)
        table.register(
            NewsFeedCodeTableViewCell.self,
            forCellReuseIdentifier: NewsFeedCodeTableViewCell.reuseIdentifier
        )
        table.separatorStyle = .none
        table.backgroundColor = .clear
        
        table.addSubview(refreshControll)
        table.tableFooterView = footerView
    }
    
    private func setupTopBars() {
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isHidden = false
        navigationItem.titleView = titleView
    }
    
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
            
        case .displayNewsFeed(let feedViewModel):
            self.feedViewModel = feedViewModel
            footerView.setTitle(feedViewModel.footerTitle)
            table.reloadData()
            refreshControll.endRefreshing()

        case .displayUser(userViewModel: let userViewModel):
            titleView.set(userViewModel: userViewModel)
        case .displayFooterLoader:
            footerView.showLoader()
            
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.1 {
            interactor?.makeRequest(request: .getNextBatch)
            
        }
    }
    
    @objc private func refresh() {
        interactor?.makeRequest(request: .getNewsFeed)
    }
    
}

extension NewsFeedViewController: UITableViewDelegate {}

extension NewsFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.reuseID, for: indexPath) as! NewsFeedTableViewCell
        let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsFeedCodeTableViewCell.reuseIdentifier,
            for: indexPath) as! NewsFeedCodeTableViewCell
        cell.delegate = self
        
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
}

//MARK: - NewsFeedCodeCellDelegate
extension NewsFeedViewController: NewsfeedCodeCellDelegate {
    func revealPost(for cell: NewsFeedCodeTableViewCell) {
        guard let indexPath = table.indexPath(for: cell) else { return }
        let cellViewModel = feedViewModel.cells[indexPath.row]
        
        interactor?.makeRequest(request: .revealPostsId(postId: cellViewModel.postId))
    }
}
