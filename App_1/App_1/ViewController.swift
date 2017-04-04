//
//  ViewController.swift
//  App_1
//
//  Created by Xinyu Qu on 4/4/17.
//  Copyright © 2017 Xinyu Qu. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var myShapeColor:Color = Color()
    var myShape:Shapes = Shapes()
    var myutility:Utility = Utility()
    var layer : CAShapeLayer?
    var startPoint : CGPoint = CGPointFromString("0")
    var endPoint:CGPoint = CGPointFromString("0")
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func DrawShapes(_ sender: UIButton) {
        
        let tagShape = sender.tag
        myShape.tagSelector = tagShape
        print(myShape.tagSelector)
        
    }

    
    @IBAction func ColorSelected(_ sender: UIButton) {        
        let tag = sender.tag
        switch tag
        {
        case DataManager.colorTag.yellow.rawValue:
            myShapeColor.colorSelector = UIColor.yellow
            print("yellow")
            
        case DataManager.colorTag.red.rawValue:
            myShapeColor.colorSelector = UIColor.red
            print("red")
        case DataManager.colorTag.green.rawValue:
            myShapeColor.colorSelector = UIColor.green
            print("green")
        case DataManager.colorTag.blue.rawValue:
            myShapeColor.colorSelector = UIColor.blue
            print("blue")
        default:
            print("no color")
            return
            
       }
    }
    
    
    @IBAction func UtilitySelected(_ sender: UIButton) {
        let tag = sender.tag
        myutility.utilityTag = tag
        print(myutility.utilityTag)

    }
    
    @IBAction func drawingPictures(_ sender: UIPanGestureRecognizer) {
        
        if sender.state == .began
        {
            startPoint = sender .location(in: sender.view)
            layer = CAShapeLayer()
            layer?.fillColor = myShapeColor.colorSelector.cgColor
            layer?.opacity = 0.2
            layer?.strokeColor = myShapeColor.colorSelector.cgColor
            self.view.layer.addSublayer(layer!)
        }
        else if sender.state == .changed
        {

            let linePath = UIBezierPath()
            let translation = sender .translation(in: sender.view)
            endPoint = sender.location(in: sender.view)
            
            switch myShape.tagSelector
            {
            //Draw line
            case DataManager.shapeTag.line.rawValue:
                myShape.drawLine(linePath: linePath, spoint: startPoint, epoint: endPoint,Layer: layer!)
 
            case DataManager.shapeTag.oval.rawValue:
                let myoval:CGRect = CGRect(x:startPoint.x, y: startPoint.y,
                                           width: translation.x,height: translation.y)
                myShape.drawOval(ovalShape: myoval, Layer: layer!)
                
            case DataManager.shapeTag.rect.rawValue:
                let myrect:CGRect = CGRect(x:startPoint.x, y: startPoint.y,
                                           width: translation.x,height: translation.y)
                myShape.drawRect(rectShape: myrect, Layer: layer!)


            default:
                return
            }



        }

        
    }
    
}

