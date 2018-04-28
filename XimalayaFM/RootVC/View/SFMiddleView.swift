//
//  SFMiddleView.swift
//  XimalayaFM
//
//  Created by brian on 2018/4/26.
//  Copyright © 2018年 Brian Inc. All rights reserved.
//

import UIKit

class SFMiddleView: UIView {
    
    @IBOutlet weak var middleImageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    
    var middleClickClosure: ((_ isPlayging: Bool) -> Void)?
    
    var isPlaying: Bool = false {
        didSet {
            if self.isPlaying == oldValue {
                return
            }
            if isPlaying {
                self.playButton.setImage(nil, for: .normal)
                print("开始播放")
                print(self.middleImageView)
                self.middleImageView.layer.resumeAnimation()
            } else {
                print("暂停播放")
                let image = UIImage(named: "tabbar_np_play")
                self.playButton.setImage(image, for: UIControlState.normal)
                self.middleImageView.layer.pauseAnimation()
            }
        }
    }
    
    //MARK: - 接口属性
    var middleImage: UIImage? {
        get {
            return self.middleImageView.image
        }
        set {
            self.middleImageView.image = self.middleImage
        }
    }
    
    static let share = SFMiddleView.middleView()
    
    private static func middleView() -> SFMiddleView {
        let middleView = Bundle.main.loadNibNamed("SFMiddleView", owner: nil, options: nil)?.first as! SFMiddleView
        return middleView
    }

    //MARK: - 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置圆角图片
        self.middleImageView.image = self.middleImageView.image?.roundImage()
        
        // 添加旋转动画
        addRotationAnimation()
        
        // 播放按钮添加事件
        self.playButton.addTarget(self, action: #selector(playOrPause), for: .touchUpInside)
        
        // 监听通知，设置按钮的状态
        NotificationCenter.default.addObserver(self, selector: #selector(setPlayState(notification:)), name: NSNotification.Name(rawValue: "playState"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setPlayImage(notification:)), name: NSNotification.Name(rawValue: "playImage"), object: nil)
    }
}

extension SFMiddleView {
    
    func addRotationAnimation() {
        self.middleImageView.layer.removeAnimation(forKey: "playAnimation")
        let basicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        basicAnimation.fromValue = 0
        basicAnimation.toValue = Float.pi * 2
        basicAnimation.repeatCount = Float.greatestFiniteMagnitude
        basicAnimation.duration = 30
        basicAnimation.isRemovedOnCompletion = false
        self.middleImageView.layer.add(basicAnimation, forKey: "playAnimation")
        
        middleImageView.layer.pauseAnimation()
    }
}

//MARK: - 事件处理
@objc
extension SFMiddleView {
    
    func playOrPause() {
        middleClickClosure?(isPlaying)
    }
    
    func setPlayImage(notification: Notification) {
        if let middleImage = notification.object as? UIImage {
            self.middleImage = middleImage
        }
    }
    
    func setPlayState(notification: Notification) {
        if let isPlaying = notification.object as? Bool {
            self.isPlaying = isPlaying
        }
    }
}
