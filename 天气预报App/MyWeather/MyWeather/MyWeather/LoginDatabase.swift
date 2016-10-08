//
//  LoginDatabase.swift
//  MyWeather
//
//  Created by DengJixiang on 16/6/29.
//  Copyright © 2016年 DengJixiang. All rights reserved.
//

import UIKit

class LoginDatabase: UIViewController,UIAlertViewDelegate,UIActionSheetDelegate {
    
    var db:SQLiteDB!  //创建数据库
    
    @IBOutlet var txtUname: UITextField!
    
    @IBOutlet var txtPassword: UITextField!
    
    var usernameTextField: UITextField?
    
    var passwordTextField: UITextField?
    
    var NewUsername : String = "" //新注册的用户
    var NewPassword : String = "" //新注册密码
    
    
    //Mark:弹窗注册
    @IBAction func Sign_in()
    {
        //创建样式是Alert的UIAlertController
        let alertController = UIAlertController(title: "注册", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        
        //添加用户名文本框
        alertController.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.placeholder = "用户名"
            self.usernameTextField = textField
        }
        
        //添加密码文本框
        alertController.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.placeholder = "密码"
            textField.secureTextEntry = true
            self.passwordTextField = textField
        }
        
        
        //创建取消按钮
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: { (action:UIAlertAction) -> Void in
            
            print("取消")
        })
        
        //创建确定按钮
        let otherAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction) -> Void in
            self.NewUsername = self.usernameTextField!.text!
            self.NewPassword = self.passwordTextField!.text!
            print("确定")
            print(self.NewUsername)
            print(self.NewPassword)
            self.saveUser()
        })
        
        
        //添加按钮
        alertController.addAction(cancelAction)
        alertController.addAction(otherAction)
        
        //弹出
        self.presentViewController(alertController, animated: true, completion: { () -> Void in
            
        })
    }
    //Mark:登录操作
    
    @IBAction func Enter(sender: AnyObject) {
        checkUser()
    }
    
    //Mark:操作数据库
    //从SQLite加载数据
    func initUser() {
        let data = db.query("select * from t_user")
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            txtUname.text = user["uname"] as? String
            txtPassword.text = user["password"] as? String
        }
    }
    //保存数据到SQLite
    func saveUser() {
        let uname = self.NewUsername
        let password = self.NewPassword
        //插入数据库，这里用到了esc字符编码函数，其实是调用bridge.m实现的
        let sql = "insert into t_user(uname,password) values('\(uname)','\(password)')"
        print("sql: \(sql)")
        //通过封装的方法执行sql
        let result = db.execute(sql)
        print(result)
    }
    //从数据库读取
    func checkUser() {
        print(txtUname.text!)  //调试用
        print(txtPassword.text!)  //调试用
        let selectData = "select uname,password from t_user where uname = '\(txtUname.text!)'"  //将用户输入的用户名在数据库中查询
        let data = db.query(selectData)
        var row = data[0]  //查询得到的数据存入数组待用
        if let name = row["uname"]{
            print(row["password"]!)
            let getPassword = row["password"]
            if txtPassword.text! == row["password"]! as! String {
                //判断密码是否正确
                print("Welcome!")
                //Mark:页面跳转
                let mainStoryboard = UIStoryboard(name: "Main",bundle:NSBundle.mainBundle())  //注意name的storyboard不能出错，否则无法跳转
                let go : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("TheMainView") as UIViewController//跳到目标版面
                self.presentViewController(go, animated: true, completion: nil)
                row = data[0]
            }
            else {
                print("Invalid password,please check out!")
            }
            
        }
        print(selectData)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //获取数据库实例
        db = SQLiteDB.sharedInstance()
        //如果表还不存在则创建表
        db.execute("create table if not exists t_user(uid integer primary key,uname varchar(20),password varchar(20))")
        //如果有数据则加载
        initUser()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
