//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Threshold on 16/9/2.
//  Copyright © 2016年 Threshold. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
   

    @IBOutlet weak var restaurantImageView: UIImageView!
    
    var restaurant:Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let restaurant = restaurant{
            restaurantImageView.image = UIImage(data: restaurant.image!)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
 

}
