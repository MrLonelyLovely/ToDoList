//
//  ViewController.swift
//  ToDoList
//
//  Created by 陈沛 on 2019/4/24.
//  Copyright © 2019 陈沛. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["购买水杯","吃药","修改密码"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
//mark: - TableViewDataSource methods
    //cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]   //每个单元格对象都会有内置的label
        
        return cell
    }

    //numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //didSelectRowAt
    //该方法用于告诉控制器用户单击了表格视图中的哪个单元格，通过indexPath参数得到该信息
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        print(itemArray[indexPath.row])
        //通过indexPath参数获取到表格视图中指定单元格对象,这个操作有点神奇
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //单击单元格后灰色高亮后逐渐变淡消失
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

