//
//  FadeOutButtonView.swift
//  healthysleep
//
//  Created by Mac on 30/06/2021.
//

import UIKit

protocol FadeOutButtonViewDelegate {
    func didTapFadeButton(_ view: FadeOutButtonView)
    func willChangeFadeOut(_ view: FadeOutButtonView)
    func didChangeFadeOut(_ view: FadeOutButtonView, value: FadeValue)
}

enum FadeOutButtonViewIdentifier {
    case MessageAlert
    case SelectionAlert
}

class FadeOutButtonView: UIView {
    
    var value: FadeValue?
    
    var delegate: FadeOutButtonViewDelegate?
    
    private var fadeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "waveform", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private var valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "", size: 10)
        label.textColor = .systemPink
        label.textAlignment = .center
        label.text = ""
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(fadeButton)
        addSubview(valueLabel)
        fadeButton.addTarget(self, action: #selector(didTapFadeButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        fadeButton.frame = CGRect(x: 0, y: 0, width: width, height: height)
        valueLabel.frame = CGRect(x: 0, y: fadeButton.bottom + 5, width: width, height: height)
    }
    
    func updateUIWith(state: PlaybackState, changed: [PSField]) {
        valueLabel.text = state.fadeOut.display
    }
    
    @objc func didTapFadeButton() {
        delegate?.didTapFadeButton(self)
    }
    
    func dequeueAlert(_ identifier: FadeOutButtonViewIdentifier) -> UIAlertController {
        switch identifier {
        case .MessageAlert:
            let alertView = UIAlertController(
                title: "Fade Out",
                message: "The Fade Out feature helps baby gently drift off to sleep. Customize to suit baby's needs. Your sound will fade out from full volume to 0 over a gradual, custom period of time without waking baby up.",
                preferredStyle: .alert
            )
            alertView.addAction(UIAlertAction(title: "SET TIME", style: .default, handler: { _ in
                self.delegate?.willChangeFadeOut(self)
            }))
            return alertView
        case .SelectionAlert:
            let alertView = UIAlertController(
                title: "Fade Out",
                message: "",
                preferredStyle: .alert
            )
            let vc = UIViewController()
            vc.preferredContentSize = CGSize(width: 200,height: 200)
            let fadeOutPicker = FadeOutPickerView()
            fadeOutPicker.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            fadeOutPicker.delegate = self
            vc.view.addSubview(fadeOutPicker)
            alertView.setValue(vc, forKey: "contentViewController")
            alertView.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                guard let value = self.value else {
                    return
                }
                self.delegate?.didChangeFadeOut(self, value: value)
            }))
            return alertView
        }
       
    }

}

extension FadeOutButtonView: FadeOutPickerViewDelegate {
    func didSelect(_ picker: FadeOutPickerView, value: FadeValue) {
        self.value = value
    }
}
