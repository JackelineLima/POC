//
//  ViewController.swift
//  POC
//
//  Created by Jackeline Pires De Lima on 26/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Seja bem-vindo"
        return label
    }()
    
    private lazy var titleCampaignLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Promoções da BLACK-FRIDAY"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        view.addSubview(titleCampaignLabel)
        
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        titleCampaignLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32).isActive = true
        titleCampaignLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

