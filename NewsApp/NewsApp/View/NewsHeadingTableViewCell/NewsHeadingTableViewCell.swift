//
//  NewsHeadingTableViewCell.swift
//  NewsApp

import UIKit
import Combine
import Kingfisher

class NewsHeadingTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!    
    @IBOutlet weak var descriptionStackView: UIStackView!
    
    
    func configureTableViewCell(presentationItem: TopHeadlineEntity) {
        if let title = presentationItem.title {
            titleLabel.text = title
        } else {
            titleLabel.isHidden = true
        }
        
        if let itemDescription = presentationItem.desc {
            descriptionLabel.text = itemDescription
        } else {
            descriptionLabel.isHidden = true
        }

        if let author = presentationItem.authorName {
            authorLabel.text = author
        } else {
            authorLabel.isHidden = true
        }

        if let imageUrl = presentationItem.imageURL, let url = URL(string: imageUrl) {
            self.thumbnailImageView.kf.setImage(with: url,
                                                placeholder: UIImage(systemName: "newspaper.circle"))
        }
    }
}
