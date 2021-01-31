//
//  PhotoTableViewCell.swift
//  SearchViewTest
//
//  Created by Boaz Frenkel on 31/01/2021.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.thumbnailImage.alpha = 0
        thumbnailImage.image = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImage.alpha = 0
        thumbnailImage.image = nil
    }
    
    private func fadeIn() {
        UIView.animate(withDuration: Constants.cellImageAnimationDuration) {
            self.thumbnailImage.alpha = 1
        }
    }
}
