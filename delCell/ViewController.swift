//
//  ViewController.swift
//  delCell
//
//  Created by 徐建峰 on 2018/6/23.
//  Copyright © 2018年 Jianfeng Xu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    let myTableView: UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64), style: .grouped)
    
    var showMenu: Bool = false
    
    var path: NSIndexPath = NSIndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTableView.delegate = self
        
        self.myTableView.dataSource = self
        
        self.myTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        self.myTableView.backgroundColor = UIColor.white
        
        self.view.addSubview(self.myTableView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCell), name: NSNotification.Name.UIMenuControllerDidHideMenu, object: nil)
    }

}
extension ViewController: UITableViewDelegate,UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.textLabel?.text = "\(indexPath.row + 1)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (!showMenu) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        showMenu = false
    }
    //pragma mark - 三个系统代理必须全部实现！
    
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        showMenu = true
        path = indexPath as NSIndexPath
        
        //cell中需要重写canBecomeFirstResponder
        let cell: TableViewCell = tableView.cellForRow(at: indexPath) as! TableViewCell
        
        cell.contentView.backgroundColor = UIColor.black
            
        //需要成为第一响应者
        cell.becomeFirstResponder()
        
        let menu: UIMenuController = UIMenuController.shared
        
        //这里的frame影响箭头的位置
        var rect: CGRect = cell.frame
        
        rect.size.width = 200
        
        menu.setTargetRect(rect, in: tableView)
        
        let item: UIMenuItem = UIMenuItem(title: "删除", action: #selector(ViewController.delMenuPress(menu:)))
        let copyItem: UIMenuItem = UIMenuItem(title: "拷贝", action: #selector(ViewController.delMenuPress(menu:)))
        
        menu.menuItems = [item,copyItem]
        
        menu.setMenuVisible(true, animated: true)
        
        return true
    }
    
    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        
        return false
    }
    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        if action == #selector(copy(_:)) {
            
            print("copy")
        }
    }
    @objc func delMenuPress(menu: UIMenuController) {
        
        print("删除成功")
        
        self.myTableView.reloadData()
    }
    @objc func reloadCell() {
        
        let cell: TableViewCell = myTableView.cellForRow(at: path as IndexPath) as! TableViewCell
        
        cell.contentView.backgroundColor = UIColor.white
    }
    
}



