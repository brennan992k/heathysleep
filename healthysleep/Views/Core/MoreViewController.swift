//
//  MoreController.swift
//  healthysleep
//
//  Created by Mac on 25/06/2021.
//

import UIKit

class MoreViewController: UIViewController {
    
    private var viewModel = MoreViewModel()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "upgrade_img_1.jpg")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "More"
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height * 1 / 3)
        tableView.frame = CGRect(x: 0, y: imageView.bottom + 12, width: view.width - 24, height: 200)
    }

}

extension MoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            let row = viewModel.data[indexPath.row]
            cell.textLabel?.text = row.name
            return cell
        }
        return UITableViewCell()
    }
    
    
}
