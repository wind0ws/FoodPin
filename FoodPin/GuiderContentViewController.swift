//
//  GuideContentViewController.swift
//  FoodPin
//
//  Created by Threshold on 16/9/9.
//  Copyright © 2016年 Threshold. All rights reserved.
//

import UIKit

class GuiderContentViewController: UIViewController {

    @IBOutlet weak var labelHeader: UILabel!
    @IBOutlet weak var labelFooter: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var doneBtn: UIButton!
    
    var index = 0
    var header:String = ""
    var footer:String = ""
    var imageName:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        labelHeader.text = header
        labelFooter.text = footer
        imageView.image = UIImage(named: imageName)
        pageControl.currentPage = index
        doneBtn.hidden = index != 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneBtnTapped(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "isGuiderShowed")
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
