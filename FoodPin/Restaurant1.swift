//
//  Restaurant.swift
//  FoodPin
//
//  Created by Threshold on 16/9/3.
//  Copyright © 2016年 Threshold. All rights reserved.
//

import Foundation

public struct Restaurant1 {
    var name:String
    var type:String
    var location:String
    var image:String
    var isVisited:Bool = false
    var evaluate:String
    
    init(name:String,type:String,location:String,image:String,isVisited:Bool){
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isVisited = isVisited
        self.evaluate = ""
    }
}