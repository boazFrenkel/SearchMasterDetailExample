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
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setup()
    }
    
    private func setup() {
        thumbnailImage.image = nil
        thumbnailImage.layer.borderColor = UIColor.black.cgColor
        thumbnailImage.layer.borderWidth = 1
    }
}
