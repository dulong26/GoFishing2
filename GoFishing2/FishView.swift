//
//  FishView.swift
//  GoFishing2
//
//  Created by Vu Thanh Tung on 1/16/18.
//  Copyright © 2018 Silverpear. All rights reserved.
//

import UIKit

class FishView: UIImageView {
    
    var status: Int?
    var speed: Int?
    var vy: Int?
    var widthFrame: Int?
    var heightFrame: Int?
    var widthFish: Int?
    var heightFish: Int?
    let MOVING: Int = 0
    let CAUGHT: Int = 1
    
    override init(frame: CGRect) {
        self.widthFish = Int(frame.width)
        self.heightFish = Int(frame.height)
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func generateFish(width: Int, height: Int) {
        self.status = MOVING
        self.speed = Int(arc4random_uniform(5)) + 2
        self.vy = Int(arc4random_uniform(3)) - 1
        self.widthFrame = width
        self.heightFrame = height
        self.image = UIImage(named: "fish1.png")
        
        let xRandom = Int(arc4random_uniform(UInt32(self.widthFrame!)))
        let yRandom = Int(arc4random_uniform(UInt32(self.heightFrame!)))
        self.frame = CGRect(x: xRandom, y: yRandom, width: self.widthFish!, height: self.heightFish!)
    }
    
    @objc func updateMove() {
        if (self.status == MOVING) {
            self.center = CGPoint(x: self.center.x + CGFloat(self.speed!), y: self.center.y + CGFloat(self.vy!))
            
            if (self.center.y < CGFloat(-self.heightFish!/2)) || (self.center.y > CGFloat(self.heightFrame! + self.heightFish!/2)) {
                self.vy = -self.vy!
            }
            
            if (self.center.x < CGFloat(-self.widthFish!/2)) {
                self.transform = CGAffineTransform.identity
                self.speed = -self.speed!
                self.vy = Int(arc4random_uniform(3)) - 1
            } else if (self.center.x > CGFloat(self.widthFrame! + self.widthFish!/2)) {
                self.transform = CGAffineTransform(scaleX: -1, y: 1)
                self.speed = -self.speed!
                self.vy = Int(arc4random_uniform(3)) - 1
            }
        } else if (self.status == CAUGHT) {
            self.center = CGPoint(x: self.center.x, y: self.center.y - 5)
        }
    }
    
    func caught() {
        if (self.status == MOVING) {
            self.status = CAUGHT
            if (self.speed! > 0) {
                self.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
            } else {
                self.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
            }
        }
    }
}
