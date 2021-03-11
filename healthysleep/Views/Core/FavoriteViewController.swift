//
//  FavoriteController.swift
//  healthysleep
//
//  Created by Mac on 25/06/2021.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    private let viewModel = FavoritesViewModel()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.reloadData(completion: { should in
            if should {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
        
    }
    
    private func configureUI() {
        title = "Favorites"
        view.backgroundColor = .systemBackground
        
        collectionView.register(SoundViewCell.self, forCellWithReuseIdentifier: SoundViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
    }
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = CGFloat(12)
        let itemWidth = (view.width - spacing * 3) / 2
        let itemHeight = itemWidth * 1.2
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let spacing = CGFloat(12)
        return UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }
    
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sounds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SoundViewCell.identifier, for: indexPath) as? SoundViewCell
        let sound = viewModel.sounds[indexPath.row]
        cell?.configure(sound: sound)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sound = viewModel.sounds[indexPath.row]
        let vc = SoundViewController(viewModel: .init(sound: sound))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

