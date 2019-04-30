//
//  ViewController.swift
//  ToDoList
//
//  Created by 陈沛 on 2019/4/24.
//  Copyright © 2019 陈沛. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    @IBAction func addButtonClicked(_ sender: Any) {
        
        //声明一个新的变量，生存期在方法的内部
        var textField = UITextField()
        
        let alert = UIAlertController(title: "添加一个新的ToDo项目", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "添加项目", style: .default) { (action) in
            //用户单击添加项目按钮以后要执行的代码
            print(textField.text!)  //test
            
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()  //重新载入数据来更新表格视图中所显示的数据
            
            
        }
        
        //在对话框alert中添加一个textfield，完成闭包的参数alertTextField代表所创建的文本框对象
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "创建一个新项目。"
            //让textField指向alertTextField，因为出了闭包，alertTextField不再存在
            textField = alertTextField
//            print(alertTextField.text!)
        }
        
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
    
    var itemArray = ["购买水杯","吃药","修改密码"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
//mark: - TableViewDataSource methods
    //cellForRowAt 重要方法
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]   //每个单元格对象都会有内置的label
        
        return cell
    }

    //numberOfRowsInSection 返回一个分区的行数
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

