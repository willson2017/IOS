//
//  ViewController.swift
//  App_1
//
//  Created by Xinyu Qu on 4/4/17.
//  Copyright © 2017 Xinyu Qu. All rights reserved.
//
/*TO Do
 * 1. organizing the code
 * 2. delete the eraser view 
 */

import UIKit


class ViewController: UIViewController {
    
    var myShapeColor:Color = Color()
    var myShape:Shapes = Shapes()
    var myutility:Utility = Utility()
    var layer : CAShapeLayer?
    var startPoint : CGPoint = CGPointFromString("0")
    var endPoint:CGPoint = CGPointFromString("0")
    var layerArray = [CAShapeLayer]()
    var currentPointArray = [CGPoint]()
    
    var inErasingState:Bool = false

   
    @IBOutlet weak var savePicButton: UIButton!
    @IBOutlet weak var EraserButton: UIButton!

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
        //for eraser
        EraserButton.isSelected = false
        inErasingState = false
    }
    
    
    @IBAction func UtilitySelected(_ sender: UIButton) {
        let tag = sender.tag
        myutility.utilityTag = tag
        print(myutility.utilityTag)

    }
    
    @IBAction func drawingPictures(_ sender: UIPanGestureRecognizer) {
        //************ eraser
        let eraserview:UIView = UIView()
        eraserview.frame = CGRect(x:0, y:0, width:15, height:15)
        eraserview.backgroundColor = UIColor.white
        eraserview.alpha = 0
        sender.view?.addSubview(eraserview)
        //************
        
        
        if sender.state == .began
        {
            print("begin\n")
            startPoint = sender .location(in: sender.view)
            if myShape.tagSelector == DataManager.shapeTag.pencil.rawValue{
                currentPointArray.append(startPoint)
            }
            layer = CAShapeLayer()
            layer?.fillColor = myShapeColor.colorSelector.cgColor
            layer?.opacity = 0.2
            layer?.strokeColor = myShapeColor.colorSelector.cgColor
            self.view.layer.addSublayer(layer!)
            layerArray.append(layer!)
            
            //////*****for eraser
            if inErasingState{
                eraserview.alpha = 1
                eraserview.center = sender.location(in: sender.view)
                sender.view?.setNeedsDisplay()
            }
            //////*****for eraser
        }
        else if sender.state == .changed
        {
            print("changede\n")
        if inErasingState == false
        {
            let linePath = UIBezierPath()
            let translation = sender .translation(in: sender.view)
            endPoint = sender.location(in: sender.view)
            if myShape.tagSelector == DataManager.shapeTag.pencil.rawValue{
                currentPointArray.append(endPoint)
            }
            
            switch myShape.tagSelector
            {
            //Draw line
            case DataManager.shapeTag.line.rawValue:
                myShape.drawLine(linePath: linePath, spoint: startPoint, epoint: endPoint,Layer: layer!)
 
            //Draw Oval
            case DataManager.shapeTag.oval.rawValue:
                let myoval:CGRect = CGRect(x:startPoint.x, y: startPoint.y,
                                           width: translation.x,height: translation.y)
                myShape.drawOval(ovalShape: myoval, Layer: layer!)
            
            //Draw Rectangle
            case DataManager.shapeTag.rect.rawValue:
                let myrect:CGRect = CGRect(x:startPoint.x, y: startPoint.y,
                                           width: translation.x,height: translation.y)
                myShape.drawRect(rectShape: myrect, Layer: layer!)

            //Free Draw
            case DataManager.shapeTag.pencil.rawValue:
                let mypath = UIBezierPath()
                myShape.drawPencil(PencilPath: mypath, points: currentPointArray, Layer: layer!)

            default:
                return
            }
        }else{
            print("changed easer")
            eraserview.center = sender.location(in: sender.view)
            }
        }
        else if sender.state == .ended{
            print("ended\n")
            currentPointArray.removeAll()
            if inErasingState{
                eraserview.alpha = 0
                eraserview.center = sender.location(in: sender.view)
                sender.view?.setNeedsDisplay()
                
            }

        }


    }
    
    //for save picture to photo album
    @IBAction func SavePic(_ sender: UIButton) {
        let height:CGFloat = self.view.bounds.size.height - self.savePicButton.frame.height - 10
        let imageSize :CGSize = CGSize(width: self.view.bounds.size.width, height: height)
        UIGraphicsBeginImageContext(imageSize)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(img, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
        //fore eraser
        EraserButton.isSelected = false
        inErasingState = false
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        var resultTitle:String?
        var resultMessage:String?
        if error != nil {
            resultTitle = "Error"
            resultMessage = "FAilure to save, please to check the permission"
        } else {
            resultTitle = "Notice!"
            resultMessage = "Save Successfully"
        }
        let alert:UIAlertController = UIAlertController.init(title: resultTitle, message:resultMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Confirmation", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //for trash bin
    @IBAction func TrashBin(_ sender: UIButton) {
        
        let actionSheetDeleteController:UIAlertController = UIAlertController(title: "Notice!", message: "Do you want to delete all", preferredStyle: .actionSheet)
        
        let deleteActionButton: UIAlertAction = UIAlertAction(title: "Delete All", style: .default) { void in
            print("delete all")
            
            for mylayer in self.layerArray{
                mylayer.removeFromSuperlayer()
            }
            
        }
        actionSheetDeleteController.addAction(deleteActionButton)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) {void in
            
        }
        actionSheetDeleteController.addAction(cancelActionButton)
        
        self.present(actionSheetDeleteController, animated: true, completion: nil)
        
        //for eraser
        EraserButton.isSelected = false
        inErasingState = false
    }
    
    @IBAction func EraserPressed(_ sender: UIButton) {
        if EraserButton.isSelected{
            //print("isselected")
            EraserButton.isSelected = false
            inErasingState = false
        }
        else{
            //print("oppsite of isselected")
            EraserButton.isSelected = true
            inErasingState = true
        }

        
    }
    
    
}

