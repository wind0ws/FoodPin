//
//  RestaurantEvaluateViewController.swift
//  FoodPin
//
//  Created by Threshold on 16/9/5.
//  Copyright © 2016年 Threshold. All rights reserved.
//

import UIKit

class RestaurantEvaluateViewController: UIViewController {

    var restaurant:Restaurant!
    
    var evaluate:String?
    
    @IBOutlet weak var evaluateStackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置背景虚化
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurEffectView.frame = view.frame
        
        //加载图片
        imageView.addSubview(blurEffectView)
        imageView.image = UIImage(data: restaurant.image! as Data)
        
        //设置评价StackView变形属性
        let scale = CGAffineTransform(scaleX: 0, y: 0)
        let translation = CGAffineTransform(translationX: 0, y: 500)
//        evaluateStackView.transform = translation //scale
        evaluateStackView.transform = scale.concatenating(translation)
        //设置成上面这样，实际上就是看不到了，缩放成0了
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //当视图加载完毕后，播放动画
        UIView.animate(withDuration: 0.5, animations: {
            () -> Void in
            self.evaluateStackView.transform = CGAffineTransform.identity //缩放到原尺寸
        })
        
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
    
    @IBAction func evaluateBtnTapped(_ sender: UIButton) {
        let tag = sender.tag
        switch tag {
        case 100:
            evaluate = "dislike"
        case 200:
            evaluate = "good"
        case 300:
            evaluate = "great"
        default:
            break
        }
        performSegue(withIdentifier: "unwindToDetailView", sender: sender)
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
