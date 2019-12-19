//
//  RootTabBarController.swift
//  qiushi-swift
//
//  Created by 中创 on 2019/12/19.
//  Copyright © 2019 LS. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addChildVC(title: "发现", img: "tabbar_find_n", selectedImg: "tabbar_find_h", type: HomeViewController())
        addChildVC(title: "我的", img: "tabbar_me_n", selectedImg: "tabbar_me_h", type: MineViewController())
        setValue(RootTabBar(), forKey: "tabBar")
    }
    
    func addChildVC(title:String, img:String, selectedImg:String, type:UIViewController) -> Void {
        let nav = BaseNavigationController(rootViewController: type)
        nav.title = title
        nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.orange], for: .selected)
        nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.gray], for: .normal)
        nav.tabBarItem.image = UIImage(named: img)
        nav.tabBarItem.selectedImage = UIImage(named: selectedImg)?.withRenderingMode(.alwaysOriginal)
        addChild(nav)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
