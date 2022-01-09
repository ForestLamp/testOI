//
//  PhotosCell.swift
//  testOI
//
//  Created by Alex Ch. on 09.01.2022.
//

import UIKit
import SDWebImage

class PhotosCell: UICollectionViewCell {
    
    static let reuseId = "PhotosCell"
    
    private let photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var googleImage: GoogleImageResult! {
        didSet {
            let photoUrl = googleImage.thumbnail
            guard let imageURL = photoUrl, let url = URL(string: imageURL)
                else {return}
            photoImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    private func updateSelectedState() {
        photoImageView.alpha = isSelected ? 0.7 : 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateSelectedState()
        setupPhotoImageView()
    }
    
    private func setupPhotoImageView() {
        addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
