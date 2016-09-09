//
//  Restaurant+CoreDataProperties.swift
//  FoodPin
//
//  Created by Threshold on 16/9/8.
//  Copyright © 2016年 Threshold. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Restaurant {
//如果更新了Model，那么删除这个文件重新生成即可。
    //这里生成的有些小问题，尽管我们在Entity设计界面去掉了Optional的勾选，但是这里还是用了可选类型。
    //修复方法也很简单，把非可选的问号去掉即可，保持和Entity一致
    @NSManaged var name: String
    @NSManaged var type: String
    @NSManaged var location: String
    @NSManaged var evaluate: String?
    @NSManaged var isVisited: NSNumber //CoreData无布尔类型，所以Entity模型中设置的布尔在这用NSNumber替代。0false，1true（C语言就是这样设置，0false，非0 true）
    @NSManaged var image: NSData? //二进制数据

}
