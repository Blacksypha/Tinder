//
//  ViewController.swift
//  Tinder
//
//  Created by Cory Dashiell on 5/8/18.
//  Copyright © 2018 Cory Dashiell. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    @IBOutlet weak var profilePic: UIImageView!
    var cardInitialCenter: CGPoint!
    
    

    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        print("translation \(translation)")
        
        if sender.state == .began {
            
            cardInitialCenter = profilePic.center
            
        } else if sender.state == .changed {
            
            profilePic.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
            
            if translation.x > 0 {
                profilePic.transform = CGAffineTransform(rotationAngle: CGFloat(13 * M_PI / 180))
            }
            else {
                
                profilePic.transform = CGAffineTransform(rotationAngle: CGFloat(-13 * M_PI / 180))
            }
            
        } else if sender.state == .ended {
            
            
            if translation.x > 50 {
                UIView.animate(withDuration: 2) {
                    self.profilePic.removeFromSuperview()
                    //self.newPic.alpha = 1
                }
            }
            else if translation.x < 50 {
                self.profilePic.removeFromSuperview()
            }
            else {
                profilePic.transform = CGAffineTransform.identity
                profilePic.center = cardInitialCenter
            }
            
        }
    }
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "profileSegue", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! ProfileViewController
        destinationViewController.image = self.profilePic.image!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


