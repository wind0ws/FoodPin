//
//  AboutTableViewController.swift
//  FoodPin
//
//  Created by Threshold on 16/9/12.
//  Copyright © 2016年 Threshold. All rights reserved.
//

import UIKit
import SafariServices // iOS9的 SFSafariViewController 需要导入这个模块

class AboutTableViewController: UITableViewController {

    var sectionTitles = ["评分和反馈","关注我们"]
    var sectionContent = [["在 App Store 上给我们评分","反馈意见"],["网站","微信","微博"]]
    var links = ["https://www.baidu.com/","https://wx.qq.com/","https://weibo.com/"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //去除底部TableView空白行
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sectionContent[section].count
    }
    
    //section 的标题
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aboutCellIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = sectionContent[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]

        return cell
    }
    
    //TableView点击选中的回调
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath as NSIndexPath).section {
        case 0://评分和反馈
            switch (indexPath as NSIndexPath).row {
            case 0:
                if let url = URL(string: "https://apple.com/itunes/charts/paid-apps/"){
                    UIApplication.shared.openURL(url)
                }
            case 1:
                //手动打开Segue 实现转场。这个转场需要在Storyboard中事先设定好
                performSegue(withIdentifier: "toWebViewIdentifier", sender: tableView)
            default:
                break
            }
        case 1:// 关注我们
            if let url = URL(string: links[(indexPath as NSIndexPath).row]){
                //SFSafariViewController只能在iOS9及以后版本使用，且需要import SafariServices
                let sfVC = SFSafariViewController(url: url, entersReaderIfAvailable: true)
                present(sfVC, animated: true, completion: nil)
            }
            break
        default:
            break
        }
        //点击选中后，处理完需要取消选中
        tableView.deselectRow(at: indexPath, animated: true)
        
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
