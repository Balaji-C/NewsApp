//
//  CategoryTableViewCell.swift
//  NewsApp

import UIKit

class SourceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var tickImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureTableViewCell(presentationItem: SourcePresentationItemEntity) {
        self.categoryLabel.text = presentationItem.sourceName
        self.tickImageView.image = presentationItem.isCheckBoxSelected ? UIImage(named: "img-selected-checkbox") : UIImage(named: "img-unselected-checkbox")
    }
}
