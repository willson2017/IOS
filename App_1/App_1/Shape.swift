//
//  Shape.swift
//  App_1
//
//  Created by Xinyu Qu on 4/4/17.
//  Copyright © 2017 Xinyu Qu. All rights reserved.
//

import Foundation
import UIKit

class Shapes{
    
    var tagInUsing:Int = 4
    
    /* name: tagSelector
     * parameters: none
     * function: Get the tag of the button pressed
     */
    var tagSelector:Int{
        get{
            return self.tagInUsing
        }
        set{
            self.tagInUsing = newValue
        }
    }
    
    /* name: drawLine
     * parameters:
     *          linePath: UIBezierPath object
     *          spoint  : start point
     *          epoint  : end   point
     *          Layer   : CAShapeLayer object
     */
    func drawLine(linePath:UIBezierPath, spoint:CGPoint, epoint:CGPoint, Layer:CAShapeLayer){
        linePath.move(to:spoint)
        linePath.addLine(to: epoint)
        Layer.path = linePath.cgPath
    }
    
    //draw rect
    func drawRect(rectShape:CGRect, Layer:CAShapeLayer){
    
        Layer.path = UIBezierPath(rect:rectShape).cgPath
    }
    //draw oval
    func drawOval(ovalShape:CGRect, Layer:CAShapeLayer){
      Layer.path = UIBezierPath(ovalIn:ovalShape).cgPath
    }
    //Free draw
    func drawPencil(){
        
    }
    
    
    
    
}
