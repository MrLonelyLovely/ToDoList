//
//  Item.swift
//  ToDoList
//
//  Created by 陈沛 on 2019/5/5.
//  Copyright © 2019 陈沛. All rights reserved.
//

import Foundation
//Encode协议可以使得Item类型能够编码为pList格式或者JSON格式
//class Item: Encodable,Decodable 又可以写成 class Item: Codable
class Item: Encodable,Decodable {
    var title = ""         //用于存储事务的名称
    var done = false       //用于指明是否完成了该事务,false代表未完成，即为未勾选
}
