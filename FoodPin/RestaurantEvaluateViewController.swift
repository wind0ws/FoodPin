//
//  RestaurantEvaluateViewController.swift
//  FoodPin
//
//  Created by Threshold on 16/9/5.
//  Copyright © 2016年 Threshold. All rights reserved.
//

import UIKit

class RestaurantEvaluateViewController: UIViewController {

    var imageName:String?
    
    
    @IBOutlet weak var evaluateStackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置背景虚化
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        blurEffectView.frame = view.frame
        
        //加载图片
        imageView.addSubview(blurEffectView)
        if let imageName = imageName {
            imageView.image = UIImage(named: imageName)
        }
        
        //设置评价StackView变形属性
        let scale = CGAffineTransformMakeScale(0, 0)
        let translation = CGAffineTransformMakeTranslation(0, 500)
//        evaluateStackView.transform = translation //scale
        evaluateStackView.transform = CGAffineTransformConcat(scale, translation)
        //设置成上面这样，实际上就是看不到了，缩放成0了
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        //当视图加载完毕后，播放动画
        UIView.animateWithDuration(0.5){
            () -> Void in
            self.evaluateStackView.transform = CGAffineTransformIdentity //缩放到原尺寸
        }
        
        // 摆动动画
//        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
//                () -> Void in
//                self.evaluateStackView.transform = CGAffineTransformIdentity
//            }, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
