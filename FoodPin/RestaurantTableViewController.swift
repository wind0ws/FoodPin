//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Threshold on 16/9/1.
//  Copyright © 2016年 Threshold. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController,NSFetchedResultsControllerDelegate,UISearchResultsUpdating {
    
    var restaurants:[Restaurant] = []
    //搜索结果
    var searchResults:[Restaurant] = []
    
    //CoreData 查询控制器
    var fetchResultsController:NSFetchedResultsController!
    var searchController:UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //启用行高自适应。记得将需要自适应高度的Label的lines设为0哦
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        //设置SearchBar
        setupSearchBar()
        //从CoreData从获取数据
        initFetchDataFromCoreData()
    }
    
    func setupSearchBar() -> Void {
        //初始化SearchController，如果参数为nil则搜索结果显示在自身所在视图中。在本例显示在tableView中
        searchController = UISearchController(searchResultsController: nil)
        let searchBar = searchController.searchBar
        searchBar.placeholder = "请输入餐馆名或地点搜索..."
        searchBar.searchBarStyle = .Minimal
//        searchBar.tintColor = UIColor.whiteColor()
//        searchBar.barTintColor = UIColor.orangeColor()
        tableView.tableHeaderView = searchBar
        //设置搜索更新器
        searchController.searchResultsUpdater = self
        //设置搜索时背景是否变暗
        searchController.dimsBackgroundDuringPresentation = false
    }
    
    func initFetchDataFromCoreData() -> Void {
        let request = NSFetchRequest(entityName: "Restaurant")
        request.sortDescriptors = [NSSortDescriptor(key:"name",ascending: true)]
        let buffer = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
        //CoreData 查询控制器
        fetchResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: buffer!, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultsController.delegate = self
        do{
            try fetchResultsController.performFetch()
            restaurants = fetchResultsController.fetchedObjects as! [Restaurant]
        }catch {
            NSLog("\(error)")
            
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.boolForKey("isGuiderShowed"){
            print("引导页已经显示过啦")
            return
        }
        if let guiderContentViewController = storyboard?.instantiateViewControllerWithIdentifier("GuiderPageController") as? GuiderPageViewController{
            //模态展示引导页。  
            self.presentViewController(guiderContentViewController, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UISearchResultsUpdating
    
    // Called when the search bar's text or scope has changed or when the search bar becomes first responder.
    @available(iOS 8.0, *)
    func updateSearchResultsForSearchController(searchController: UISearchController){
        if var textToSearch =  searchController.searchBar.text{
            //去除用户输入中的空格
            textToSearch = textToSearch.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            searchResults = restaurants.filter(){
                (restaurant) -> Bool in
                return restaurant.name.containsString(textToSearch)||restaurant.location.containsString(textToSearch)
            }
            tableView.reloadData()
        }
    }

    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        // 1.更新表格（视图）
        switch type {
        case .Insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
            }
        case .Delete:
            if let indexPath = indexPath{
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        case .Update:
            if let indexPath = indexPath{
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        default:
            tableView.reloadData()
        }
        //2. 更新数据
        restaurants = controller.fetchedObjects as! [Restaurant]
    }

   
    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1 //总共有几块 Section，本例就一种类型
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.active {
            return searchResults.count
        }
        return restaurants.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell", forIndexPath: indexPath) as!RestaurantTableViewCell
        let index = indexPath.row
        //Row显示的数据来源：搜索框在使用时就显示搜索结果，否则显示从CoreData读取出来的数据
        let restaurant = searchController.active ? searchResults[index] : restaurants[index]
        cell.name.text = restaurant.name
        cell.picture.image = UIImage(data: restaurant.image!)
        cell.location.text = restaurant.location
        cell.type.text = restaurant.type
        
        //设置图片圆角.(设为图片框一半的时候就是常见的圆形图片，小于图片框一半的时候就是圆角矩形。)
        cell.picture.layer.cornerRadius = cell.picture.frame.size.width / 2
        cell.picture.clipsToBounds = true
//        cell.textLabel?.text = restaurants[indexPath.row]
//        cell.imageView?.image = UIImage(named: restaurantPictures[indexPath.row])
        
        cell.favImageView.hidden = !restaurant.isVisited.boolValue
        
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
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return !searchController.active //搜索时显示的结果不可编辑
    }
    

    
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
//        let rowIndex = indexPath.row
        //let restaurant = restaurants[indexPath.row]
        let buffer = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let restaurant = self.fetchResultsController.objectAtIndexPath(indexPath) as! Restaurant
        
        let shareRowAction = UITableViewRowAction(style: .Default, title: "分享"){
            [unowned self] (rowAction,indexPath) -> Void in
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
            (rowAction,indexPath) -> Void in
            
            buffer.deleteObject(restaurant)
            
            do{
                try buffer.save()
            }catch{
                NSLog("\(error)")
            }
            
            //self.restaurants.removeAtIndex(rowIndex)
            //刷新数据：会刷新全部。下面的deleteRowsAtIndexPaths 能带删除动画
            //            tableView.reloadData()
            // Delete the row from the data source
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
        let visitAction = UITableViewRowAction(style: .Default, title: restaurant.isVisited.boolValue ? "没来过":"来过"){
            (action:UITableViewRowAction,indexPath:NSIndexPath) -> Void in
            restaurant.isVisited = !restaurant.isVisited.boolValue
            do{
                try buffer.save()
            }catch{
                NSLog("\(error)")
            }
//            self.restaurants[indexPath.row].isVisited = !(self.restaurants[indexPath.row].isVisited.boolValue)
//            //刷新数据
//            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        visitAction.backgroundColor = UIColor.brownColor()
//        var actions = [UITableViewRowAction]()
//        actions.append(shareRowAction)
//        return actions
        return [visitAction,shareRowAction,deleteAction] //这个相当于创建一个新数组
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
            let row = tableView.indexPathForSelectedRow?.row
            //从搜索栏点击时也要特殊
            destVC.restaurant = searchController.active ? searchResults[row!] : restaurants[row!]
        }
    }
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue){
        if segue.identifier == "unwindToHomeList" {
            
        }
    }
 
    


}
