//
//  SettingsViewController.swift
//  CameraApplication
//
//  Created by Carey, Brady on 11/11/16.
//  Copyright © 2016 Carey, Brady. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsViewControllerDelegate: class {
    func settingsViewControllerFinished(settingsViewController: SettingsViewController)
}


class SettingsViewController: UIViewController{
    
    @IBOutlet weak var sliderBrush: UISlider!
    @IBOutlet weak var sliderOpacity: UISlider!
    
    @IBOutlet weak var imageViewBrush: UIImageView!
    @IBOutlet weak var imageViewOpacity: UIImageView!
    
    @IBOutlet weak var labelBrush: UILabel!
    @IBOutlet weak var labelOpacity: UILabel!
    
    @IBOutlet weak var sliderRed: UISlider!
    @IBOutlet weak var sliderGreen: UISlider!
    @IBOutlet weak var sliderBlue: UISlider!
    
    @IBOutlet weak var labelRed: UILabel!
    @IBOutlet weak var labelGreen: UILabel!
    @IBOutlet weak var labelBlue: UILabel!

    var brush: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    
    weak var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        self.delegate?.settingsViewControllerFinished(settingsViewController: self)
    }
    
    @IBAction func colorChanged(sender: UISlider) {
        red = CGFloat(sliderRed.value / 255.0)
        labelRed.text = NSString(format: "%d", Int(sliderRed.value)) as String
        green = CGFloat(sliderGreen.value / 255.0)
        labelGreen.text = NSString(format: "%d", Int(sliderGreen.value)) as String
        blue = CGFloat(sliderBlue.value / 255.0)
        labelBlue.text = NSString(format: "%d", Int(sliderBlue.value)) as String
        
        drawPreview()
    }
    
    @IBAction func sliderChanged(sender: UISlider) {
        if sender == sliderBrush {
            brush = CGFloat(sender.value)
            labelBrush.text = NSString(format: "%.2f", brush.native) as String
        } else {
            opacity = CGFloat(sender.value)
            labelOpacity.text = NSString(format: "%.2f", opacity.native) as String
        }
        
        drawPreview()
    }
    
    func drawPreview() {
        UIGraphicsBeginImageContext(imageViewBrush.frame.size)
        var context = UIGraphicsGetCurrentContext()
        
        //CGContextSetLineCap(context, kCGLineCapRound)
        //CGContextSetLineWidth(context!, brush)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brush)
        
        //CGContextSetRGBStrokeColor(context!, red, green, blue, 1.0)
        //CGContextMoveToPoint(context, 45.0, 45.0)
        //CGContextAddLineToPoint(context, 45.0, 45.0)
        //CGContextStrokePath(context!)
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: opacity)
        let pt : CGPoint = CGPoint(x: 45.0, y: 45.0)
        context?.move(to: pt)
        context?.addLine(to: pt)
        context?.strokePath()
        
        imageViewBrush.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIGraphicsBeginImageContext(imageViewBrush.frame.size)
        context = UIGraphicsGetCurrentContext()
        
        //CGContextSetLineCap(context, kCGLineCapRound)
        //CGContextSetLineWidth(context!, 20)
        //CGContextMoveToPoint(context, 45.0, 45.0)
        //CGContextAddLineToPoint(context, 45.0, 45.0)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(20)
        context?.move(to: pt)
        context?.addLine(to: pt)
        
        //CGContextSetRGBStrokeColor(context!, red, green, blue, opacity)
        //CGContextStrokePath(context!)
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: opacity)
        context?.strokePath()
        
        imageViewOpacity.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sliderBrush.value = Float(brush)
        labelBrush.text = NSString(format: "%.1f", brush.native) as String
        sliderOpacity.value = Float(opacity)
        labelOpacity.text = NSString(format: "%.1f", opacity.native) as String
        sliderRed.value = Float(red * 255.0)
        labelRed.text = NSString(format: "%d", Int(sliderRed.value)) as String
        sliderGreen.value = Float(green * 255.0)
        labelGreen.text = NSString(format: "%d", Int(sliderGreen.value)) as String
        sliderBlue.value = Float(blue * 255.0)
        labelBlue.text = NSString(format: "%d", Int(sliderBlue.value)) as String
        
        drawPreview()
    }

}
