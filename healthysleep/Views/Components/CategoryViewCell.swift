//
//  CategoryViewCell.swift
//  healthysleep
//
//  Created by Mac on 25/06/2021.
//

import UIKit

class CategoryViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryViewCell"
    
    //component
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .center
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont(name: "Montserrat-Medium", size: 16)
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 1
        
        return nameLabel
    }()
    
    //init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let spacing = CGFloat(12)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true
        backgroundColor = .white
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height)
        nameLabel.frame = CGRect(x: spacing, y: contentView.height - spacing - 16, width: contentView.width, height: 16)
    }
    
    func configure(category: Category) {
        nameLabel.text = category.name.capitalizingFirstLetter()
        imageView.image = UIImage(named: category.image)
    }
}
