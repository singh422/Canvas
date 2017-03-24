//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Avinash Singh on 23/03/17.
//  Copyright © 2017 Avinash Singh. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var trayOriginalCenter: CGPoint!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        trayDownOffset = 200
        
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        if sender.state == .began{
        trayOriginalCenter = trayView.center
        }
        if sender.state == .changed{
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        }
        if sender.state == .ended{
            if velocity.y > 0{
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.trayView.center = self.trayDown
                }, completion: nil)
            
            }
            else{
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.trayView.center = self.trayUp
                }, completion: nil)
            }
        }
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        
        //new instance of pangesturereco
        
        if sender.state == .began{
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            let gest = UIPanGestureRecognizer(target: self, action: #selector(onMoving(sender:)))
            //addgesture to newlycretedaface
            newlyCreatedFace.addGestureRecognizer(gest)
            newlyCreatedFace.isUserInteractionEnabled = true
            
        }
        else if sender.state == .changed{
            
            let translation = sender.translation(in: view)
            
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        }
        else if sender.state == .ended{
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        }
        
        
        
    }
    
    func onMoving(sender: UIPanGestureRecognizer)
    {
        let translation = sender.translation(in: view)
        
        if(sender.state == .began) {
            
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
        } else if(sender.state == .changed) {
            
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        } else if(sender.state == .ended) {
            
            
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
