//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Threshold on 16/9/1.
//  Copyright © 2016年 Threshold. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var restaurants = [
        Restaurant(name: "咖啡胡同", type: "咖啡 & 茶店", location: "香港上环德辅道西78号G/F", image: "cafedeadend.jpg", isVisited: false) ,
        Restaurant(name: "霍米", type: "咖啡", location: "香港上环文咸东街太平山22-24A，B店", image: "homei.jpg", isVisited: false) ,
        Restaurant(name: "茶.家", type: "茶屋", location: "香港葵涌和宜合道熟食市场地下", image: "teakha.jpg", isVisited: false) ,
        Restaurant(name: "洛伊斯咖啡", type: "奥地利式 & 休闲饮料", location: "香港新界葵涌屏富径", image: "cafeloisl.jpg", isVisited: false) ,
        Restaurant(name: "贝蒂生蚝", type: "法式", location: "香港九龙尖沙咀河内道18号(近港铁尖东站N3,N4出口) ", image: "petiteoyster.jpg", isVisited: false) ,
        Restaurant(name: "福奇餐馆", type: "面包房", location: "香港岛中环都爹利街13号乐成行地库中层", image: "forkeerestaurant.jpg", isVisited: false) ,
        Restaurant(name: "阿波画室", type: "面包房", location: "香港岛铜锣湾轩尼诗道555号崇光百货地库2楼30号铺", image: "posatelier.jpg", isVisited: false) ,
        Restaurant(name: "伯克街面包坊", type: "巧克力", location: "4 Hickson Rd、The Rocks NSW 2000", image: "bourkestreetbakery.jpg", isVisited: false) ,
        Restaurant(name: "黑氏巧克力", type: "咖啡", location: "31 Wheat Rd、Sydney NSW 2001", image: "haighschocolate.jpg", isVisited: false) ,
        Restaurant(name: "惠灵顿雪梨", type: "美式 & 海鲜", location: "1/11-31 York Street Sydney NSW Australia、Sydney NSW 2000", image: "palominoespresso.jpg", isVisited: false) ,
        Restaurant(name: "北州", type: "美式", location: "Macy's、151 W 34th St Fifth Floor、New York, NY 10001", image: "upstate.jpg", isVisited: false) ,
        Restaurant(name: "布鲁克林塔菲", type: "美式", location: "250 8th Ave、New York, NY 10107", image: "traif.jpg", isVisited: false) ,
        Restaurant(name: "格雷厄姆大街肉", type: "早餐 & 早午餐", location: "55-1 Riverwalk Pl、West New York, NJ 07093", image: "grahamavenuemeats.jpg", isVisited: false) ,
        Restaurant(name: "华夫饼 & 沃夫", type: "法式 & 茶", location: "1585 Broadway、New York, NY 10036-8200", image: "wafflewolf.jpg", isVisited: false) ,
        Restaurant(name: "五叶", type: "咖啡 & 茶", location: "1460 Broadway、New York, NY 10036", image: "fiveleaves.jpg", isVisited: false) ,
        Restaurant(name: "眼光咖啡", type: "拉丁美式", location: "250 8th Ave、New York, NY 10107", image: "cafelore.jpg", isVisited: false) ,
        Restaurant(name: "忏悔", type: "西班牙式", location: "822 Lexington Ave、New York, NY 10065", image: "confessional.jpg", isVisited: false) ,
        Restaurant(name: "巴拉菲娜", type: "西班牙式", location: "Unit 2, Eldon Chambers、30-32 Fleet St、London EC4Y 1AA", image: "barrafina.jpg", isVisited: false) ,
        Restaurant(name: "多尼西亚", type: "西班牙式", location: "Waterloo Station、London SE1 7LY", image: "donostia.jpg", isVisited: false) ,
        Restaurant(name: "皇家橡树", type: "英式", location: "Unit 4a、44-58 Brompton Rd、London SW3 1BW", image: "royaloak.jpg", isVisited: false) ,
        Restaurant(name: "泰咖啡", type: "泰式", location: "7-9 Golders Green Rd、London NW11 8DY", image: "thaicafe.jpg", isVisited: false)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //启用行高自适应。记得将需要自适应高度的Label的lines设为0哦
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
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
        cell.name.text = restaurants[index].name
        cell.picture.image = UIImage(named: restaurants[index].image)
        cell.location.text = restaurants[index].location
        cell.type.text = restaurants[index].type
        
        //设置图片圆角.(设为图片框一半的时候就是常见的圆形图片，小于图片框一半的时候就是圆角矩形。)
        cell.picture.layer.cornerRadius = cell.picture.frame.size.width/2
        cell.picture.clipsToBounds = true
//        cell.textLabel?.text = restaurants[indexPath.row]
//        cell.imageView?.image = UIImage(named: restaurantPictures[indexPath.row])
        
        cell.favImageView.hidden = !restaurants[index].isVisited
        
//        cell.accessoryType = alreadyComeRestaurantsSet.contains(restaurants[index]) ? .Checkmark:.None
        
//        if alreadyComeRestaurantsSet.contains(restaurants[index]) {
//            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
//        }else{
//            cell.accessoryType = UITableViewCellAccessoryType.None
//        }
//        
        return cell
    }
    
    /*
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
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let rowIndex = indexPath.row
        if editingStyle == .Delete {
            restaurants.removeAtIndex(rowIndex)
            //刷新数据：会刷新全部。下面的deleteRowsAtIndexPaths 能带删除动画
//            tableView.reloadData()
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    //一旦重写实现这个方法，系统将不会提供默认的左滑删除的功能
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let restaurant = restaurants[indexPath.row]
        
        let shareRowAction = UITableViewRowAction(style: .Default, title: "分享"){
            (rowAction,indexPath) -> Void in
            let shareAlert = UIAlertController(title: "分享菜单", message: "分享到", preferredStyle: .ActionSheet)
            let sinaWeiBoAlertAction = UIAlertAction(title: "新浪微博", style: .Default,handler: nil)
            let weChatAlertAction = UIAlertAction(title: "微信", style: .Default, handler: nil)
            let qqAlertAction = UIAlertAction(title: "QQ", style: .Default, handler: nil)
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            shareAlert.addAction(sinaWeiBoAlertAction)
            shareAlert.addAction(weChatAlertAction)
            shareAlert.addAction(qqAlertAction)
            shareAlert.addAction(cancelAction)
            self.presentViewController(shareAlert, animated: true, completion: nil)
        }
//        shareRowAction.backgroundColor = UIColor.greenColor()
        shareRowAction.backgroundColor = UIColor(red: 0, green: 171/255, blue: 97/255, alpha: 1)
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "删除"){
            [unowned self] (rowAction,indexPath) -> Void in
            let rowIndex = indexPath.row
            self.restaurants.removeAtIndex(rowIndex)
            //刷新数据：会刷新全部。下面的deleteRowsAtIndexPaths 能带删除动画
            //            tableView.reloadData()
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
        let visitAction = UITableViewRowAction(style: .Default, title: restaurant.isVisited ? "没来过":"来过"){
            [unowned self] (action:UITableViewRowAction,indexPath:NSIndexPath) -> Void in
            self.restaurants[indexPath.row].isVisited = !(self.restaurants[indexPath.row].isVisited)
            //刷新数据
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        visitAction.backgroundColor = UIColor.brownColor()
//        var actions = [UITableViewRowAction]()
//        actions.append(shareRowAction)
//        return actions
        return [visitAction,shareRowAction,deleteAction] //这个相当于创建一个新数组，数组包含一个默认元素
    }
 

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
//        if segue.identifier == "showRestaurantDetail"{
//            let destVC = segue.destinationViewController as! RestaurantDetailViewController
//            destVC.restaurant = restaurants[(tableView.indexPathForSelectedRow?.row)!]
//        }
        if segue.identifier == "showRestaurantDetail" {
            let destVC = segue.destinationViewController as! RestaurantDetailTableViewController
            destVC.restaurant = restaurants[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
 
    


}
