//
//  DetailView.swift
//  MVVM
//
//  Created by Avinash Singh on 20/01/2023.
//


import UIKit

class DetailView: UIView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        createSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        createSubview()
    }
    
    //MARK: - Views
    private let detailScrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let scrollViewContainer: UIStackView = {
        
        let scrollViewContainer = UIStackView()
        scrollViewContainer.axis = .vertical
        scrollViewContainer.spacing = 10
        scrollViewContainer.layoutMargins = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        scrollViewContainer.isLayoutMarginsRelativeArrangement = true
        scrollViewContainer.translatesAutoresizingMaskIntoConstraints = false
        return scrollViewContainer
    }()
    
    let imageViewForNewsIcon: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "placeholder")
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return imageView
    }()
    
    let labelForNewsTitle: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelForNewsDescription: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelForNewsAuthor: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let seeMoreButton: UIButton = {
        
        let button = UIButton()
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.backgroundColor  = .systemBlue
        return button
    }()
    
    func createSubview() {
        
        backgroundColor = .white
        addSubview(detailScrollView)
        detailScrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(imageViewForNewsIcon)
        scrollViewContainer.addArrangedSubview(labelForNewsTitle)
        scrollViewContainer.addArrangedSubview(labelForNewsDescription)
        scrollViewContainer.addArrangedSubview(labelForNewsAuthor)
        scrollViewContainer.addArrangedSubview(seeMoreButton)
        
        detailScrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        detailScrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        detailScrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        detailScrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        scrollViewContainer.leadingAnchor.constraint(equalTo: detailScrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: detailScrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: detailScrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: detailScrollView.bottomAnchor).isActive = true
        scrollViewContainer.widthAnchor.constraint(equalTo: detailScrollView.widthAnchor).isActive = true
    }
}
