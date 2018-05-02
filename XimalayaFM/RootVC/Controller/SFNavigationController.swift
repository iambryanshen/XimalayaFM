//
//  SFNavigationController.swift
//  XimalayaFM
//
//  Created by brian on 2018/4/24.
//  Copyright © 2018年 Brian Inc. All rights reserved.
//

import UIKit

class SFNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        if viewController.view.tag == 666 {
            view.tag = 888
            
            // 添加middleView
            let middleView = SFMiddleView.middleView()
            middleView.middleClickClosure = SFMiddleView.share.middleClickClosure
            middleView.isPlaying = SFMiddleView.share.isPlaying
            middleView.middleImage = SFMiddleView.share.middleImage
            
            let middleViewX = (kScreenW - middleViewWidth) * 0.5
            let middleViewY = kScreenH - middleViewWidth
            middleView.frame = CGRect(x: middleViewX, y: middleViewY, width: middleViewWidth, height: middleViewWidth)
            viewController.view.addSubview(middleView)
            
        }
    }
}
