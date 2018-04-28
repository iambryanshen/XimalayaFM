//
//  SFTabBarController.swift
//  XimalayaFM
//
//  Created by brian on 2018/4/24.
//  Copyright © 2018年 Brian Inc. All rights reserved.
//

import UIKit
import SFExtensions

class SFTabBarController: UITabBarController {
    
    /**
     获取单例对象
     
     @return TabBarController
     */
    static let share = SFTabBarController()
}

extension SFTabBarController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
    }
}

extension SFTabBarController {
    
    func setTabBar() {
        
        self.setValue(SFTabBar(), forKey: "tabBar")
    }
}

extension SFTabBarController {
    /**
     添加子控制器的block
     
     @param addVCBlock 添加代码块
     
     @return TabBarController
     */
    class func tabBarControllerWithAddChildVCsBlock(addVCBlock: ((SFTabBarController) -> Void)?) -> SFTabBarController {
        let tabbarVC = SFTabBarController.share
        if let addVCBlock = addVCBlock {
            addVCBlock(tabbarVC)
        }
        return tabbarVC
    }
    
    /**
     添加子控制器
     
     @param vc                子控制器
     @param normalImageName   普通状态下图片
     @param selectedImageName 选中图片
     @param isRequired        是否需要包装导航控制器
     */
    func addChildVC(childVC: UIViewController, normalImage: String, selectedImage: String, isRequiredNavigationController: Bool) {
        if isRequiredNavigationController {
            let navigationController = SFNavigationController(rootViewController: childVC)
            childVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: normalImage)?.originalImage(), selectedImage: UIImage(named: selectedImage)?.originalImage())
            addChildViewController(navigationController)
        } else {
            addChildViewController(childVC)
        }
    }
}
