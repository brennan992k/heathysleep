//
//  FavoriteButtonView.swift
//  healthysleep
//
//  Created by Mac on 30/06/2021.
//

import UIKit

protocol FavoriteButtonViewDelegate {
    func didTapFavoriteButton(_ view: FavoriteButtonView, completion: ((Bool) -> Void)?)
}

class FavoriteButtonView: UIView {
    
    var delegate: FavoriteButtonViewDelegate?
    
    private var favoriteButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(favoriteButton)
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        favoriteButton.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
    }
    
    func updateUIWith(state: PlaybackState, changed: [PSField]) {
        let image: UIImage?
        if state.isFavorites {
            image = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        } else {
            image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        }
        favoriteButton.setImage(image, for: .normal)
    }
    
    @objc func didTapFavoriteButton() {
        delegate?.didTapFavoriteButton(self, completion: nil)
    }

}
