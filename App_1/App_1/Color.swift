//
//  Color.swift
//  App_1
//
//  Created by Xinyu Qu on 4/4/17.
//  Copyright © 2017 Xinyu Qu. All rights reserved.
//

import Foundation
import UIKit

class Color{
    
    var shapesColor:UIColor    
    
    
    init(){
        shapesColor = UIColor.yellow
    }
    
    
    var colorSelector:UIColor{
        get{
            return self.shapesColor
        }
        
        set{
            self.shapesColor = newValue
        }
    }
}
