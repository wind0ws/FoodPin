//
//  GuiderPageViewController.swift
//  FoodPin
//
//  Created by Threshold on 16/9/9.
//  Copyright © 2016年 Threshold. All rights reserved.
//

import UIKit

class GuiderPageViewController: UIPageViewController,UIPageViewControllerDataSource {

    var headers = ["私人定制","餐馆定位","美食发现"]
    var images = ["foodpin-intro-1","foodpin-intro-2","foodpin-intro-3"]
    var footers = ["好店随时加，打造自己的美食向导","马上找到大餐位置","发现其他吃货的珍藏"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self // TableViewController 默认就设置dataSource为自身，但是PageViewController需要自己设定
        if let startVC = guiderPageViewControllerAtIndex(0){
            setViewControllers([startVC], direction: .forward, animated: true, completion: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - UIPageViewControllerDataSource
    
    @available(iOS 5.0, *)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        var index  = (viewController as! GuiderContentViewController).index
        index -= 1
        return guiderPageViewControllerAtIndex(index)
    }
    
    @available(iOS 5.0, *)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        var index  = (viewController as! GuiderContentViewController).index
        index += 1
        return guiderPageViewControllerAtIndex(index)
    }
    
    /*
    UIPageViewControllerDataSource 可选方法。可以实现在底部显示PagerView的当前位置和总个数。但是颜色不能自定义
     
    // A page indicator will be visible if both methods are implemented, transition style is 'UIPageViewControllerTransitionStyleScroll', and navigation orientation is 'UIPageViewControllerNavigationOrientationHorizontal'.
    // Both methods are called in response to a 'setViewControllers:...' call, but the presentation index is updated automatically in the case of gesture-driven navigation.
    @available(iOS 6.0, *)
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int{
         // The number of items reflected in the page indicator.
        return headers.count
    }
    @available(iOS 6.0, *)
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        // The selected item reflected in the page indicator.
        return 0
    }
     
     */
    
    func guiderPageViewControllerAtIndex(_ index:Int) -> UIViewController? {
        // if case 模式 ＝ 变量    //模式在前，变量在后
        if case 0..<headers.count = index {
            // GuiderContentController 这个字符串是在storyboard中设置的
            if let guiderContentVC =  storyboard?.instantiateViewController(withIdentifier: "GuiderContentController") as? GuiderContentViewController{
                guiderContentVC.imageName = images[index]
                guiderContentVC.header = headers[index]
                guiderContentVC.footer = headers[index]
                guiderContentVC.index = index
                return guiderContentVC
            }
        }
        return nil
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
