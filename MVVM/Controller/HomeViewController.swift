//
//  HomeViewController.swift
//  MVVM
//
//  Created by Avinash Singh on 20/01/2023.
//



import UIKit

class HomeViewController: UIViewController, CompletionHandlerDelegate {
    
    //MARK: - Variables
    var viewModel: HomeViewModel!
    var homeView = HomeView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModel = HomeViewModel(completionDelegate: self)
        viewModel.requestForNews()
        homeView.newsTableView.dataSource = self
        homeView.newsTableView.delegate = self
    }
    
    override func loadView() {
        
        view = homeView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationItem.title = NSLocalizedString(Strings.navigationTitleForLandingPage, comment: "")
    }
    
    //MARK: - Network Completion
    func completionHandler() {
        
        DispatchQueue.main.async {
            self.homeView.newsTableView.reloadData()
        }
    }
    
    //MARK: - Show AlertView
    func showErrorInformation() {
        
        if let message = viewModel.alertMessage {
            showAlertView(message)
        }
    }
    
    //MARK: - Show Loading Indicator
    func statusOfLoadingIndicator() {
        
        DispatchQueue.main.async {
            if self.viewModel.isLoading {
                self.homeView.activityIndicator.startAnimating()
            } else {
                self.homeView.activityIndicator.stopAnimating()
            }
            UIView.animate(withDuration: 0.2, animations: {
                self.homeView.newsTableView.alpha = self.viewModel.tableViewAlphaValue()
            })
        }
    }
    
    //MARK: - Show Alertview Meassage
    private func showAlertView( _ alertViewMessage: String ) {
        
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: Strings.titleForAlertView, message: alertViewMessage, preferredStyle: .alert)
            alertView.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alertView, animated: true, completion: nil)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableView Delegates
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: IdentifierName.newsCell,
            for: indexPath) as? NewsTableViewCell
        else {
            fatalError("Unable to dequeue tableview cell")
        }
        let article = viewModel.getArticleInformation(at: indexPath)
        cell.setArticleValues(article: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.articleCount
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let topStory = viewModel.getArticleInformation(at: indexPath) else { return }
        let detailsViewController = NewsDetailsViewController(topStoryViewModel: topStory)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
}
