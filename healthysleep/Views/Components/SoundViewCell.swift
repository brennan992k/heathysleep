//
//  SoundViewCell.swift
//  healthysleep
//
//  Created by Mac on 25/06/2021.
//

import UIKit

class SoundViewCell: UICollectionViewCell {
    
    static let identifier = "SoundViewCell"
    
    //component
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont(name: "Montserrat-Medium", size: 14)
        nameLabel.textColor = .black
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
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.width)
       
        nameLabel.frame = CGRect(x: spacing, y: imageView.bottom + spacing , width: contentView.width, height: 16)
        nameLabel.center.x = contentView.center.x
        nameLabel.textAlignment = .center
    }
    
    override func prepareForReuse() {
        nameLabel.text = "No name"
        imageView.image = UIImage(systemName: "photo")
    }
    
    func configure(sound: Sound) {
        nameLabel.text = sound.name.capitalizingFirstLetter()
        imageView.image = UIImage(named: sound.image)
    }

}
