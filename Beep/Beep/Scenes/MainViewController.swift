//
//  MainViewController.swift
//  Beep
//
//  Created by Jack Uzcategui on 25/04/2020.
//  Copyright © 2020 __jackdaw__. All rights reserved.
//

import UIKit
import QuartzCore
import SnapKit

class MainViewController: UIViewController {
    let timeLabel: UILabel
    let ghostLabel: UILabel
    let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.timeLabel = UILabel()
        self.ghostLabel = UILabel()
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.notifyTimeChange = update
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        update()
    }
    
    func setupUI() {
        let fontSize:CGFloat = 120
        
        view.backgroundColor = .lcdGreen
        
        view.addSubview(ghostLabel)
        ghostLabel.font = UIFont.lcdFont(with: fontSize)
        ghostLabel.snp.makeConstraints {
            $0.center.equalTo(view)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        ghostLabel.text = "00 00"
        ghostLabel.textColor = .ghostBlack
        ghostLabel.textAlignment = .center
        
        view.addSubview(timeLabel)
        timeLabel.font = UIFont.lcdFont(with: fontSize)
        timeLabel.snp.makeConstraints {
            $0.center.equalTo(view)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        timeLabel.textAlignment = .center
        timeLabel.layer.shadowColor = UIColor.black.cgColor
        timeLabel.layer.shadowOffset = CGSize(width: 3, height: 3)
        timeLabel.layer.shadowRadius = 3.0
        timeLabel.layer.shadowOpacity = 0.5
        timeLabel.layer.masksToBounds = false
        timeLabel.layer.shouldRasterize = true
    }
    
    func update() {
        timeLabel.text = viewModel.time
    }
}

