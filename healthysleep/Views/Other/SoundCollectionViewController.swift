//
//  SoundCollectionController.swift
//  healthysleep
//
//  Created by Mac on 25/06/2021.
//

import UIKit

class SoundCollectionViewController: UIViewController {
    
    private let viewModel: SoundCollectionViewModel?
    
    init(viewModel: SoundCollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        title = viewModel?.category?.name
        view.backgroundColor = .systemBackground
        
        collectionView.register(SoundViewCell.self, forCellWithReuseIdentifier: SoundViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
    }
}

extension SoundCollectionViewController: UICollectionViewDelegateFlowLayout {
    
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

extension SoundCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.sounds.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SoundViewCell.identifier, for: indexPath) as? SoundViewCell
        if let sound = viewModel?.sounds[indexPath.row] {
            cell?.configure(sound: sound)
            return cell ?? UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let sound = viewModel?.sounds[indexPath.row] else {
            return
        }
        let vc = SoundViewController(viewModel: .init(sound:sound))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
