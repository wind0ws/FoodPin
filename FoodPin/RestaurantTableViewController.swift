//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Threshold on 16/9/1.
//  Copyright © 2016年 Threshold. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    var restaurants = ["咖啡胡同", "霍米", "茶.家", "洛伊斯咖啡", "贝蒂生蚝", "福奇餐馆", "阿波画室", "伯克街面包坊", "黑氏巧克力", "惠灵顿雪梨", "北州", "布鲁克林塔菲", "格雷厄姆大街肉", "华夫饼 & 沃夫", "五叶", "眼光咖啡", "忏悔", "巴拉菲娜", "多尼西亚", "皇家橡树", "泰咖啡"]
    var restaurantPictures = ["cafedeadend.jpg", "homei.jpg", "teakha.jpg", "cafeloisl.jpg", "petiteoyster.jpg", "forkeerestaurant.jpg", "posatelier.jpg", "bourkestreetbakery.jpg", "haighschocolate.jpg", "palominoespresso.jpg", "upstate.jpg", "traif.jpg", "grahamavenuemeats.jpg", "wafflewolf.jpg", "fiveleaves.jpg", "cafelore.jpg", "confessional.jpg", "barrafina.jpg", "donostia.jpg", "royaloak.jpg", "thaicafe.jpg"]
    var restaurantLocations = ["香港", "香港", "香港", "香港", "香港", "香港", "香港", "悉尼", "悉尼", "悉尼", "纽约", "纽约", "纽约", "纽约", "纽约", "纽约", "纽约", "伦敦", "伦敦", "伦敦", "伦敦"]
    
    var restaurantTypes = ["咖啡 & 茶店","咖啡", "茶屋", "奥地利式 & 休闲饮料","法式", "面包房", "面包房", "巧克力", "咖啡", "美式 & 海鲜", "美式", "美式","早餐 & 早午餐", "法式 & 茶", "咖啡 & 茶", "拉丁美式", "西班牙式", "西班牙式", "西班牙式", "英式", "泰式"]
    
    //这里用存餐馆名称作为判断是否来过这个餐馆的标志，但是有一个潜在的bug，如果餐馆名称相同就会发生。实际中应存放餐馆UID
    var alreadyComeRestaurantsSet:Set<String> = Set<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1 //总共有几块 Section，本例就一种类型
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell", forIndexPath: indexPath) as!RestaurantTableViewCell
        let index = indexPath.row
        cell.name.text = restaurants[index]
        cell.picture.image = UIImage(named: restaurantPictures[index])
        cell.location.text = restaurantLocations[index]
        cell.type.text = restaurantTypes[index]
        
        //设置图片圆角.(设为图片框一半的时候就是常见的圆形图片，小于图片框一半的时候就是圆角矩形。)
        cell.picture.layer.cornerRadius = cell.picture.frame.size.width/2
        cell.picture.clipsToBounds = true
//        cell.textLabel?.text = restaurants[indexPath.row]
//        cell.imageView?.image = UIImage(named: restaurantPictures[indexPath.row])
        
        cell.favImageView.hidden = !alreadyComeRestaurantsSet.contains(restaurants[index])
        
//        cell.accessoryType = alreadyComeRestaurantsSet.contains(restaurants[index]) ? .Checkmark:.None
        
//        if alreadyComeRestaurantsSet.contains(restaurants[index]) {
//            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
//        }else{
//            cell.accessoryType = UITableViewCellAccessoryType.None
//        }
//        
        return cell
    }
    
    //选中某行后执行效果
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let restaurantName = restaurants[indexPath.row]
        let alert = UIAlertController(title: "您好", message: "亲，您点击了\(restaurantName)", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        let dialAction = UIAlertAction(title: "拨号 021-123456\(indexPath.row)", style: .Default){
            [unowned self] (action:UIAlertAction) -> Void in
            let tipAlert = UIAlertController(title: "提示", message: "您拨打的号码暂时无法接通", preferredStyle: .Alert)
            let okAction =  UIAlertAction(title: "好", style: .Default){
                (action:UIAlertAction) -> Void in
                print("用户点击了拨打电话提示框中的OK")
            }
            tipAlert.addAction(okAction)
            self.presentViewController(tipAlert, animated: true, completion: nil)
        }
        let isCome = alreadyComeRestaurantsSet.contains(restaurantName)
        let alreadyComeAction = UIAlertAction(title: isCome ? "我没来过":"我来过", style: .Default){
            [unowned self] (action:UIAlertAction) -> Void in
            if isCome{
                self.alreadyComeRestaurantsSet.remove(restaurantName)
            }else{
                self.alreadyComeRestaurantsSet.insert(restaurantName)
            }
            
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! RestaurantTableViewCell
            cell.favImageView.hidden = isCome
            
            //设置Cell Accessory（辅助，附件，配件）类型 (显示在右边，有五种：对勾，信息样式，信息加V形，V形，无)
//            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
//            if !self.alreadyComeRestaurantsSet.contains(restaurantName){
//                self.alreadyComeRestaurantsSet.insert(restaurantName)
//            }
        }
        alert.addAction(cancelAction)
        alert.addAction(dialAction)
        alert.addAction(alreadyComeAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //隐藏显示状态栏
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
