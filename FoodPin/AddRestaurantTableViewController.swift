//
//  AddRestaurantTableViewController.swift
//  FoodPin
//
//  Created by Threshold on 16/9/8.
//  Copyright © 2016年 Threshold. All rights reserved.
//

import UIKit
import CoreData

class AddRestaurantTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var restaurant:Restaurant?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var restaurantName: UITextField!
    @IBOutlet weak var restaurantType: UITextField!
    @IBOutlet weak var restaurantAddress: UITextField!
    @IBOutlet weak var isVisitedSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //设置ImageView 的 Constraint
        setImageViewConstraint()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setImageViewConstraint() -> Void {
        //MARK 手动设置约束
        let leftConstraint = NSLayoutConstraint(item: imageView, attribute: .Leading, relatedBy: .Equal, toItem: imageView.superview, attribute: .Leading, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: imageView, attribute: .Trailing, relatedBy: .Equal, toItem: imageView.superview, attribute: .Trailing, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: imageView.superview, attribute: .Top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: imageView, attribute: .Bottom, relatedBy: .Equal, toItem: imageView.superview, attribute: .Bottom, multiplier: 1, constant: 0)
        
        //使 Constraint 生效
        leftConstraint.active = true
        rightConstraint.active = true
        topConstraint.active = true
        bottomConstraint.active = true
    }
    
    @IBAction func saveBtnTapped(sender: AnyObject) {
        //获取管理托管对象缓冲区上下文.
        let buffer = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
        restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: buffer!) as? Restaurant
        restaurant?.name = restaurantName.text!
        restaurant?.type = restaurantType.text!
        restaurant?.location = restaurantAddress.text!
        if let image = imageView.image{
            restaurant?.image = UIImagePNGRepresentation(image)
        }
        restaurant?.isVisited = isVisitedSwitch.on //NSNumber 类型与数字和布尔类型自动转换。
        do{
            try buffer?.save()
        }catch {
            print(error)
            return
        }
        /*
         关于 do try catch
         
         do {
            try expression
            statements
         } catch pattern 1 {
            statements
         } catch pattern 2 where condition {
            statements
         }
         
         do {
            try d.writeToFile("Hello", options: [])
         } catch let error as NSError {
            print ("Error: \(error.domain)")
         }
         
         do {
            try login("onevcat", password: "123")
         } catch LoginError.UserNotFound {
            print("UserNotFound")
         } catch LoginError.UserPasswordNotMatch {
            print("UserPasswordNotMatch")
         }
         
         let y: Int?
         do {
            y = try someThrowingFunction()
         } catch {
            y = nil
            print(error)
         }
         
         
         //try?不处理异常。出现异常返回nil
         func fetchData() -> Data? {
            if let data = try? fetchDataFromDisk() { return data }
            if let data = try? fetchDataFromServer() { return data }
            return nil
         }
         
         if let num = try? methodThrowsWhenPassingNegative(100) {
            print(num.dynamicType)
         } else {
            print("failed")
         }

         
         //try!不处理异常。如果异常发生了会crash
         let photo = try! loadImage("./Resources/John Appleseed.jpg")

 
        */
        
        performSegueWithIdentifier("unwindToHomeList", sender: sender)
        
    }
    
    

    // MARK: - Table view data source
//静态生成的  无需下面的方法
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
    
    //TableView选中方法
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) { //判断是否有权限访问照片
                let imagePicker = UIImagePickerController() //OK，有权限，初始化选择照片控制器
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .PhotoLibrary
                imagePicker.delegate = self
                //模态弹出
                self.presentViewController(imagePicker, animated: true){
                    () -> Void in
                    print("打开了选择照片ViewController")
                }
            }
        }
        //取消选中
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = .ScaleAspectFill //平铺
        //裁边  超出部分的图片裁掉  通常与Aspect这种模式搭配
        imageView.clipsToBounds = true
        
        //让相册选择视图退场
        dismissViewControllerAnimated(true, completion: nil)

    }
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
//        
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
