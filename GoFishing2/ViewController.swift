//
//  ViewController.swift
//  GoFishing2
//
//  Created by Vu Thanh Tung on 1/16/18.
//  Copyright © 2018 Silverpear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gameManager: GameManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameManager = GameManager()
        self.view.addSubview((self.gameManager?.hookView)!)
        self.gameManager?.addFishToViewController(viewController: self, width: Int(self.view.bounds.width), height: Int(self.view.bounds.height))
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap(sender:))))
        
        _ = Timer.scheduledTimer(timeInterval: 0.025, target: self.gameManager!, selector: Selector(("updateMove")), userInfo: nil, repeats: true)
    }
    
    @objc func onTap(sender: UITapGestureRecognizer) {
        let tapPoint = sender.location(in: self.view)
        self.gameManager?.dropHookerAtX(x: Int(tapPoint.x))
    }
    
    @IBAction func btAddFish(_ sender: UIButton) {
        self.gameManager?.addFishToViewController(viewController: self, width: Int(self.view.bounds.width), height: Int(self.view.bounds.height))
    }
    
    @IBAction func btReset(_ sender: UIButton) {
        self.gameManager?.fishViews?.removeAllObjects()
        for object in self.view.subviews {
            if object.isKind(of: FishView.self) {
                object.removeFromSuperview()
            }
        }
        self.gameManager?.addFishToViewController(viewController: self, width: Int(self.view.bounds.width), height: Int(self.view.bounds.height))
    }
    
}

