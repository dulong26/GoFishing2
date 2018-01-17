//
//  HookerView.swift
//  GoFishing2
//
//  Created by Vu Thanh Tung on 1/16/18.
//  Copyright © 2018 Silverpear. All rights reserved.
//

import UIKit

class HookerView: UIImageView {

    let PREPARE = 0
    let DROPPING = 1
    let DRAWINGUP = 2
    let CAUGHTFISH = 3
    var status: Int?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = UIImage(named: "hook.png")
        self.status = PREPARE
    }
    
    @objc func updateMove() {
        if (self.status == DROPPING) {
            self.center = CGPoint(x: self.center.x, y: self.center.y + 10)
            if (self.frame.origin.y >= 0) {
                self.status = DRAWINGUP
            }
        } else if (self.status == DRAWINGUP) {
            self.center = CGPoint(x: self.center.x, y: self.center.y - 20)
            if (self.frame.origin.y + self.frame.height < 0) {
                self.status = PREPARE
            }
        } else if (self.status == CAUGHTFISH) {
            self.center = CGPoint(x: self.center.x, y: self.center.y - 5)
            if (self.frame.origin.y + self.frame.height < 0) {
                self.status = PREPARE
            }
        }
    }
    
    func dropDownAtX(x: Int) {
        if (self.status == PREPARE) {
            self.center = CGPoint(x: CGFloat(x), y: self.center.y)
            self.status = DROPPING
        }
    }
}
