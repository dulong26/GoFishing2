//
//  GameManager.swift
//  GoFishing2
//
//  Created by Vu Thanh Tung on 1/16/18.
//  Copyright © 2018 Silverpear. All rights reserved.
//

import UIKit

class GameManager: NSObject {
    
    var fishViews: NSMutableArray?
    var hookView: HookerView?
    
    override init() {
        fishViews = NSMutableArray()
        hookView = HookerView(frame: CGRect(x: 0, y: -UIScreen.main.bounds.height, width: 20, height: UIScreen.main.bounds.height))
    }
    
    func addFishToViewController(viewController: UIViewController, width: Int, height: Int) {
        let fishView = FishView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        fishView.generateFish(width: width, height: height)
        self.fishViews?.add(fishView)
        viewController.view.addSubview(fishView)
    }
    
    func bite(fishView: FishView) {
        if (fishView.status == fishView.MOVING) && (self.hookView?.status == self.hookView?.DROPPING) {
            fishView.caught()
            fishView.center = CGPoint(x: (self.hookView?.center.x)!, y: (self.hookView?.frame.origin.y)! + (self.hookView?.frame.height)! + fishView.frame.width/2)
            self.hookView?.status = self.hookView?.CAUGHTFISH
        }
    }
    
    @objc func updateMove() {
        self.hookView?.updateMove()
        for fishView in self.fishViews! {
            (fishView as AnyObject).updateMove()
            if (fishView as AnyObject).frame.contains(CGPoint(x: (self.hookView?.center.x)!, y: (self.hookView?.frame.origin.y)! + (self.hookView?.frame.height)!)) {
                bite(fishView: fishView as! FishView)
            }
        }
    }
    
    func dropHookerAtX(x: Int) {
        self.hookView?.dropDownAtX(x: x)
    }
}
