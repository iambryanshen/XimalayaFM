//
//  SFHomeViewController.swift
//  XimalayaFM
//
//  Created by brian on 2018/4/24.
//  Copyright © 2018年 Brian Inc. All rights reserved.
//

import UIKit

class SFHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let playVC = SFPlayViewController()
        playVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(playVC, animated: true)
    }
}
