//
//  NewsTableViewCell.swift
//  MVVM
//
//  Created by Avinash Singh on 20/01/2023.
//


import Foundation
import UIKit

class NewsTableViewCell: UITableViewCell, ImageDownloadCompletionDelegate {
    
    var viewModel: NewsTableCellViewModel!
    
    func setArticleValues(article: Article?) {
        
        guard let article = article else { return }
        viewModel = NewsTableCellViewModel(downloadCompletionDelegate: self)
        labelNewsTitle.text = article.newsTitle
        labelNewsCoverBy.text = article.newsByLine
        guard let urlImageString = viewModel.getImageUrlString(topStory: article) else { return }
        viewModel.downloadingImage(imageUrlString: urlImageString)
    }
    let containerView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    let profileImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let labelNewsTitle: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .black
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelNewsCoverBy: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor =  .black
        label.numberOfLines = 2
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        contentView.addSubview(profileImageView)
        containerView.addSubview(labelNewsTitle)
        containerView.addSubview(labelNewsCoverBy)
        contentView.addSubview(containerView)
        
        profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        labelNewsTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        labelNewsTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        labelNewsTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        labelNewsCoverBy.topAnchor.constraint(equalTo: labelNewsTitle.bottomAnchor).isActive = true
        labelNewsCoverBy.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    func completedImageDownload(newsImage: Data?) {
        
        guard let data = newsImage else { return }
        profileImageView.image = UIImage(data: data)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        viewModel.cancelRequest()
    }
}
