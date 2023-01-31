//
//  NewsDetailsViewController.swift
//  MVVM
//
//  Created by Avinash Singh on 20/01/2023.
//

import Foundation
import UIKit
import SafariServices

class NewsDetailsViewController: UIViewController, ImageDownloadCompletionDelegate {
    
    //MARK: - Variables
    var topStory: Article!
    var viewModel: NewsDetailsViewModel!
    var addDetailView = DetailView()
    
    convenience init(topStoryViewModel: Article) {
        
        self.init()
        self.topStory = topStoryViewModel
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        assignTextValue()
    }
    override func loadView() {
        
        view = addDetailView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationItem.title = NSLocalizedString(Strings.newsDetails, comment: "")
    }
    //MARK: - Adding value and adding button action
    private func assignTextValue()  {
        
        viewModel = NewsDetailsViewModel(downloadCompletionDelegate: self)
        guard let topStory = topStory else { return }
        if let imageUrlString = viewModel.getImageUrlString(topStory: topStory) {
            viewModel.downloadingImage(imageUrlString: imageUrlString)
        }
        addDetailView.labelForNewsTitle.text = topStory.newsTitle
        addDetailView.labelForNewsDescription.text = topStory.newsAbstract
        addDetailView.labelForNewsAuthor.text = topStory.newsByLine
        addDetailView.seeMoreButton.addTarget(self, action: #selector(openWebKit), for: .touchUpInside)
        addDetailView.seeMoreButton.setTitle(NSLocalizedString(Strings.seeMore, comment: ""), for: .normal)
        
    }
    //MARK: - Completion
    func completedImageDownload(newsImage:Data?){
        
        guard let data = newsImage else { return }
        addDetailView.imageViewForNewsIcon.image = UIImage(data: data)
    }
    
    //MARK: - Opening SFSafariViewController
    @IBAction func openWebKit(_ sender: Any) {
        
        guard let urlString = topStory?.newsWebUrl else { return }
        guard let url = URL(string: urlString) else { return }
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let safariViewController = SFSafariViewController(url: url, configuration: config)
        present(safariViewController, animated: true)
    }
    deinit {
        print("deint called")
    }
}

class TestDetail: UIViewController {
    var name: String?
    convenience init(name: String) {
        self.init()
        self.name  = name
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
