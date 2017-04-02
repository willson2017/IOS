//
//  ViewController.swift
//  test
//
//  Created by Xinyu Qu on 4/3/17.
//  Copyright © 2017 Xinyu Qu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var startPoint:CGPoint = CGPointFromString("0")
    
    var layer:CAShapeLayer?
    
    var configG:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func operation(_ sender: UIPanGestureRecognizer) {
        
        if sender.state == .began
        {
            startPoint = sender .location(in: sender.view)
            layer = CAShapeLayer()
            layer?.fillColor = UIColor.red.cgColor
            layer?.opacity = 0.2
            layer?.strokeColor = UIColor.blue.cgColor
            self.view.layer.addSublayer(layer!)
        }
        else if sender.state == .changed
        {
             let translation = sender .translation(in: sender.view)
            switch configG{
            case 1:
                //for oval
                layer?.path = (UIBezierPath(ovalIn:CGRect(x:startPoint.x,
                                                          y: startPoint.y,
                                                          width: translation.x,
                                                          height: translation.y))).cgPath
            case 2:
                layer?.path = (UIBezierPath(rect:CGRect(x:startPoint.x,
                                                          y: startPoint.y,
                                                          width: translation.x,
                                                          height: translation.y))).cgPath

                
            default:
                print("no idea")
                
            }
           
        }
    }
    
    

    @IBAction func globalConfig(_ sender: UIButton) {
        
        configG = 2 //oval
    }

}

