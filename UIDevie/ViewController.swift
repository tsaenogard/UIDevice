//
//  ViewController.swift
//  UIDevie
//
//  Created by smallHappy on 2017/4/27.
//  Copyright © 2017年 SmallHappy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let functionArray = [
        "uuid",                 //0
        "systemName",           //1
        "systemVersion",        //2
        "name",                 //3
        "orientation",          //4
        "userInterfaceIdiom",   //5
        "multitaskingSupported",//6
        "batteryState",         //7
        "batteryLevel"          //8
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(UIView(frame: CGRect.zero))
        let tableView = UITableView(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: self.view.frame.height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            print(Utilities.device.uuid)
        case 1:
            print(Utilities.device.systemName)
        case 2:
            print(Utilities.device.systemVersion)

        case 3:
            print(Utilities.device.name)
        case 4:
            print(Utilities.device.orientation)
        case 5:
            print(Utilities.device.userInterfaceIdiom)
        case 6:
            print("多工\(Utilities.device.multitaskingSupported ? "支持" : "不支持")")
        case 7:
            print("電池狀態：\(Utilities.device.batteryState)")
        case 8:
            print("電池電量\(Utilities.device.batteryLevel)")
        default:
            break
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.functionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellID")
        }
        cell!.textLabel?.text = self.functionArray[indexPath.row]
        return cell!
    }
    
}
