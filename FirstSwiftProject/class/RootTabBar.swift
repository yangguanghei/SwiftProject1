//
//  RootTabBar.swift
//  FirstSwiftProject
//
//  Created by 中创 on 2019/12/19.
//  Copyright © 2019 LS. All rights reserved.
//

import UIKit

class RootTabBar: UITabBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.barTintColor = UIColor.white
        for view in self.subviews where view is UIControl {
            var frame = view.frame
            frame.origin.y = -10
            view.frame = frame;
        }
        
    }

}
