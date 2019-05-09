//
//  ViewController.swift
//  ToDoList
//
//  Created by 陈沛 on 2019/4/24.
//  Copyright © 2019 陈沛. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    //因为UserDefaults是单例模式，所以通过类方法standard获取该类的实例
//    let defaults = UserDefaults.standard
    
//    var itemArray = ["购买水杯","吃药","修改密码","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s"]
    
    var itemArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //dataFilePath用于存储应用的document的路径
    //FileManager类用于管理应用中的文件系统，并通过default属性获取该类的实例，它是个单例类
    //在Document文件夹中创建一个新的文件，名为Items.pList,但只是生成一个地址，还没有实际创建文件
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.pList")
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func addButtonClicked(_ sender: Any) {
        
        //声明一个新的变量，生存期在方法的内部
        var textField = UITextField()
        
        let alert = UIAlertController(title: "添加一个新的ToDo项目", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "添加项目", style: .default) { (action) in
            //用户单击添加项目按钮以后要执行的代码
            print(textField.text!)  //test
            
//            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let newItem = Item(context: self.context)
            
            newItem.title = textField.text!
            newItem.done = false                //让done属性的默认值为false，这样不会报1570的错
            newItem.parentCategory = self.selectedCategory  //将selectedCategory的值赋给Item对象的parentCategory关系属性
            
            self.itemArray.append(newItem)
//            self.itemArray.append(textField.text!)
            
            self.saveItems()
            
            //创建一个PropertyListEncoder类的实例，然后通过它的encoder()方法将Item类型数组编码为pList格式
            //注意两点：
            //一：encode()方法具有throw功能，所以需要使用do...catch语句；
            //二：为了可以对Item类型的对象编码，需要让Item类符合Encodable协议
//            let encoder = PropertyListEncoder()
////            let data = encoder.encode(self.itemArray)
//            do {
//                let data = try encoder.encode(self.itemArray)
//                try data.write(to:self.dataFilePath!)      //将数据存储到指定的路径
//            } catch {
//                print("编码错误：\(error)")
//            }
            
            //通过set方法，将itemArray数组存储到UserDefaults中，与其对应的键名为ToDoListArray
//            self.defaults.set(self.itemArray,forKey:"ToDoListArray")
            
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
//        print(dataFilePath!)
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
//            itemArray = items
//        }
        
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
//        loadItems()
        
        
        
//        let newItem = Item()
//        newItem.title = "购买水杯"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "吃药"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "修改密码"
//        itemArray.append(newItem3)
        
        //再向itemArray数组中添加117个newItem
//        for index in 4...120 {
//            let newItem = Item()
//            newItem.title = "第\(index)件事务"
//            itemArray.append(newItem)
//        }
    }
    
//mark: - TableViewDataSource methods
    //cellForRowAt 重要方法
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title   //每个单元格对象都会有内置的label
        
        let item = itemArray[indexPath.row]
        cell.accessoryType = item.done == true ? .checkmark : .none
//        if itemArray[indexPath.row].done == false {
//            cell.accessoryType = .none
//            print("更新第：\(indexPath.row)")
//        } else {
//            cell.accessoryType = .checkmark
//            print("更新第：\(indexPath.row)")
//        }
        
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
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        //通过CoreData修改数据
        //当用户点击某个事项后，会在该事项title的结尾处加上特定文字
        //相关改动只会影响到context区域，直到调用save()指令前，所有的修改都不会影响到persistentContainer
//        let title = itemArray[indexPath.row].title!
//        itemArray[indexPath.row].setValue(title + " - (已完成）", forKey: "title")
        
        saveItems()
        
        tableView.beginUpdates()               //通过此方法告诉表格视图，马上要更新某些单元格对象的界面了
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
        tableView.endUpdates()                 //更新单元格的操作结束
        
        //单击单元格后灰色高亮后逐渐变淡消失
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //Mark : - nscoder方法
    
    func saveItems() {
//        let encoder = PropertyListEncoder()
        do {
//            let data = try encoder.encode(itemArray)
//            try data.write(to: dataFilePath!)
//            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            try context.save()
        } catch {
//            print("编码错误：\(error)")
            print("保存context错误：\(error)")
        }
        tableView.reloadData()
    }
    
    //从磁盘上的Items.pList文件读取之前保存的Item类型的数据
//    func loadItems() {
//        //try后不加问号会报错，如下：
//        //Errors thrown from here are not handled
//        //Initializer for conditional binding must have Optional type, not 'Data'
//        //因为Data的初始化方法是throw类型，所以需要使用try命令；
//        //又因为其生成的对象是可选类型，所以这里又使用可选绑定将其拆包
//        //如果从Item.pList读出了数据，则会执行if语句体中的代码
//        if let data = try? Data(contentsOf: dataFilePath!){
//            let decoder = PropertyListDecoder()
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("解码item错误！")
//            }
//        }
//    }
    
    // = Item.fetchRequest() 如果不输入参数，则此为参数的默认值
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(),predicate: NSPredicate? = nil ) {
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
        //过滤
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,addtionalPredicate])
        }
        
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("从context获取数据错误：\(error)")
        }
        tableView.reloadData()
    }
    
    //?????
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
}

extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[c] %@", searchBar.text!) //***谓词过滤语句
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]        //对搜索到的Item对象按照title属性增量排序
        
        loadItems(with: request)
        
        print(searchBar.text!)
    }
    
    //一旦搜索栏中的文字内容发生了变化，就会调用该方法。
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {    //若搜索栏为空
            loadItems()                    //则显示所有事项
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    
    
}
