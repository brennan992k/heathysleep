//
//  SoundController.swift
//  healthysleep
//
//  Created by Mac on 25/06/2021.
//

import UIKit

class SoundViewController: UIViewController {
    
    private var viewModel: SoundViewModel?
    
    private var soundConfigView = SoundConfigView()
    
    private  var soundControlView = SoundControlView()
    
    init(viewModel: SoundViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        updateUIWith(state: viewModel.state, changed: [.duration, .fadeOut, .percentage, .progressionTo, .sound, .state, .isFavorites])
        viewModel.on(self, selector: #selector(updateUI))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func updateUI(_ notification: Notification) {
        guard let state = notification.userInfo?["state"] as? PlaybackState, let changed = notification.userInfo?["changed"] as? [PSField] else {
            return
        }
       updateUIWith(state: state, changed: changed)
    }
    
    func updateUIWith(state: PlaybackState, changed: [PSField]) {
        soundControlView.updateUIWith(state: state, changed: changed)
        soundConfigView.updateUIWith(state: state, changed: changed)
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(soundConfigView)
        view.addSubview(soundControlView)
        soundConfigView.delegate = self
        soundControlView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        soundConfigView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.width * 1.25)
        soundControlView.frame = CGRect(x: 0 , y: soundConfigView.bottom, width: view.width, height: view.height - soundConfigView.height)
    }

}

extension SoundViewController: SoundConfigViewDelegate {
    func didChangedAlarm(_ configView: SoundConfigView, value: Date) {
        viewModel?.changeAlarm(value: value, completion: nil)
    }
    
    func didChangeFadeOut(_ configView: SoundConfigView, value: FadeValue) {
        viewModel?.changeFadeOut(value: value, completion: nil)
    }
    
    func didTapAlarmButton(_ configView: SoundConfigView, alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }
    
    func didTapFadeButton(_ configView: SoundConfigView, alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }
    
    func didTapFavoriteButton(_ configView: SoundConfigView, completion: ((Bool) -> Void)?) {
        viewModel?.toggleFavorite(completion: completion)
    }
    
}

extension SoundViewController: SoundControlViewDelegate {
    func didTapPlay(_ controllView: SoundControlView, completion: ((Bool) -> Void)?) {
        viewModel?.play(completion: completion)
    }
    
    func didTapStop(_ controllView: SoundControlView, completion: ((Bool) -> Void)?) {
        viewModel?.pause(completion: completion)
    }
    
    func didChangeDuration(_ controllView: SoundControlView, value: DurationValue, completion: ((Bool) -> Void)?) {
        viewModel?.changeDuration(value: value, completion:completion)
    }
    
    func didChangeVolume(_ controllView: SoundControlView, value: Float, completion: ((Bool) -> Void)?) {
        viewModel?.changeVolume(value: value, completion: completion)
    }
}
