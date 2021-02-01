//
//  PhotoDetailsViewController.swift
//  SearchViewTest
//
//  Created by Boaz Frenkel on 31/01/2021.
//

import UIKit
import SDWebImage

class PhotoDetailsViewController: UIViewController {
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userFullName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet weak var likesCount: UILabel!
    
    var photoDetails: PhotoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOutlets()
    }
    
    private func setupOutlets() {
        guard let details = photoDetails else { return }
        mainImageView.sd_imageTransition = .fade
        mainImageView.sd_setImage(with: details.imageURL, completed: nil)
        descriptionLabel.text = details.description
        userImageView.sd_setImage(with: details.user.thumbnailURL, completed: nil)
        userFullName.text = details.user.fullName
        userName.text = details.user.userName
        userBio.text = details.user.bio
        likesCount.text = "Likes\n\(details.likesNumber)"
    }
}
