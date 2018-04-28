//
//  SFTabBar.swift
//  XimalayaFM
//
//  Created by brian on 2018/4/24.
//  Copyright © 2018年 Brian Inc. All rights reserved.
//

import UIKit

let middleViewWidth: CGFloat = 69   // tabBar中间按钮的高度比tabBar正常高度49高20
let kScreenW: CGFloat = UIScreen.main.bounds.width
let kScreenH: CGFloat = UIScreen.main.bounds.height

class SFTabBar: UITabBar {
    
    lazy var middleView: SFMiddleView = {
        let middleView = SFMiddleView.share
        middleView.middleClickClosure = middleClickClosure
        addSubview(middleView)
        return middleView
    }()
    
    var middleClickClosure: ((_ isPlayging: Bool) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SFTabBar {
    
    func setup() {
        
        // 设置样式, 去除tabbar上面的黑线
        self.barStyle = .black
        
        // 设置背景图片
        self.backgroundImage = UIImage(named: "tabbar_bg")
    }
}

//MARK: - 系统布局回调
extension SFTabBar {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let count = self.items?.count else {return}
        
        let subViewW: CGFloat = self.bounds.width / (CGFloat(count) + 1)
        let subViewH: CGFloat = SystemCommon.kTabBarHeight
        
        var index: Int = 0
        for subView in self.subviews {
            
            if subView.isKind(of: NSClassFromString("UITabBarButton")!) {
                
                if index == count / 2 {
                    index += 1
                }
                
                let subViewX: CGFloat = CGFloat(index) * subViewW
                let subViewY: CGFloat = 0
                
                subView.frame = CGRect(x: subViewX, y: subViewY, width: subViewW, height: subViewH)
                
                index += 1
            }
        }

        self.middleView.frame = CGRect(x: (kScreenW - middleViewWidth) * 0.5, y: (subViewH - middleViewWidth), width: middleViewWidth, height: middleViewWidth)
    }
}

extension SFTabBar {
    
    /// 重写该方法，实现点击中间的middleView，只有中间的圆形按钮可以响应事件
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        let pointAtMiddleView = convert(point, to: middleView)
        
        let middleViewCenter = CGPoint(x: 34.5, y: 34.5)
        
        let dis = sqrt(pow(pointAtMiddleView.x - middleViewCenter.x, 2) + pow(pointAtMiddleView.y - middleViewCenter.y, 2));
        
        let minX = (self.bounds.width - middleViewWidth) * 0.5
        let maxX = (self.bounds.width + middleViewWidth) * 0.5
        if dis > 34.5 && point.x > minX && point.x < maxX {
            return false
        }
        
        return true
    }
}
