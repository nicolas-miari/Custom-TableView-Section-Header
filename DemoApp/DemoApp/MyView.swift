//
//  MyView.swift
//  DemoApp
//
//  Created by Nicolás Miari on 2017/08/30.
//  Copyright © 2017 Nicolás Miari. All rights reserved.
//

import UIKit

class MyView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if let touch = touches.first {
            let locationInThisView = touch.location(in: self)

            let locationInWindow = touch.location(in: nil)

        }
    }

}
