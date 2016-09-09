//
//  RestaurantDetailTableViewController.swift
//  FoodPin
//
//  Created by Threshold on 16/9/3.
//  Copyright © 2016年 Threshold. All rights reserved.
//

import UIKit

class RestaurantDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var evaluateButton: UIButton!
    
    func getDetailItemValues(restaurant:Restaurant) -> [(String,String)] {
        var result = [(String,String)]()
        result.append(("餐馆名:",restaurant.name))
        result.append(("餐馆类型:",restaurant.type))
        result.append(("地址:",restaurant.location))
        result.append(("来过:", restaurant.isVisited.boolValue ? "来过啦" : "尚未来过"))
        return result
    }
    
    var restaurant:Restaurant!
    
    var restaurantItems:[(String,String)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantItems = getDetailItemValues(restaurant)
        imageView.image = UIImage(data: restaurant.image!)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.title = restaurant.name
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //设置UITableView Cell 行高自适应
        //1.估算TableViewCell的行高
        tableView.estimatedRowHeight = 36
        //2.设置行高自适应
        tableView.rowHeight = UITableViewAutomaticDimension
        //3.对Cell中的控件进行约束，要确保设置了顶距和底距为0
    }
    
    override func viewDidAppear(animated: Bool) {
        if let evaluate = restaurant.evaluate{
            evaluateButton.setImage(UIImage(named: evaluate), forState: .Normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 这是单个页面这样设置。全局需要在info.plist中添加一个key ViewController－base status bar
    //有NavigationBar的时候可以通过下面的语句更改状态栏颜色
    // default 就是默认的黑色   black是亮色（通常状态栏颜色字体是白色）
//    override func viewDidAppear(animated: Bool) {
//        self.navigationController?.navigationBar.barStyle = .Black
//    }
//    
    // MARK: - Table view data source
    
    //    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    //        return 1 //总共有几块 Section，本例就一种类型
    //    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurantItems.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailCell", forIndexPath: indexPath) as! RestaurantDetailTableViewCell
        let item = restaurantItems[index]
        cell.itemName.text = item.0
        cell.itemValue.text = item.1
        return cell
    }
    
    /*
     //选中某行后执行效果
     override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     
     }*/
    
    //隐藏显示状态栏
    //    override func prefersStatusBarHidden() -> Bool {
    //        return true
    //    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        
//    }
    
    //一旦重写实现这个方法，系统将不会提供默认的左滑删除的功能
//    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
//        
//    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "evaluateRestaurant" {
            let vc = segue.destinationViewController as! RestaurantEvaluateViewController
            vc.restaurant = restaurant
        }else if segue.identifier == "showMap" {
            let vc = segue.destinationViewController as! MapViewController
            vc.restaurant = restaurant
        }
        
    }
    
    @IBAction func closeSegue(segue:UIStoryboardSegue){
        //反向转场 unwind 传值
        if segue.identifier == "unwindToDetailView" {
            let sourceVC = segue.sourceViewController as! RestaurantEvaluateViewController
            if let evaluate = sourceVC.evaluate {
                NSLog("你的评价是：\(evaluate)")
                self.restaurant.evaluate = evaluate
                self.evaluateButton.setImage(UIImage(named: evaluate), forState: .Normal)
                //保存评价
                let buffer = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
                do{
                    try buffer?.save()
                }catch{
                    NSLog("\(error)")
                }
            }
        }
    }
    

}
