//
//  HomeView.swift
//  MVVM
//
//  Created by Avinash Singh on 20/01/2023.
//


import UIKit

class HomeView: UIView {
    
    var newsTableView: UITableView!
    var activityIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        createTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        createTableView()
    }
    
    func createTableView() {
        
        backgroundColor = .white
        newsTableView = UITableView()
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.backgroundColor = .lightGray
        newsTableView.accessibilityLabel = AccessibilityLabel.newsTableView
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: IdentifierName.newsCell)
        addSubview(newsTableView)
        
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        newsTableView.topAnchor.constraint(equalTo:safeAreaLayoutGuide.topAnchor).isActive = true
        newsTableView.leftAnchor.constraint(equalTo:safeAreaLayoutGuide.leftAnchor).isActive = true
        newsTableView.rightAnchor.constraint(equalTo:safeAreaLayoutGuide.rightAnchor).isActive = true
        newsTableView.bottomAnchor.constraint(equalTo:safeAreaLayoutGuide.bottomAnchor).isActive = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.center = self.center
        addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

