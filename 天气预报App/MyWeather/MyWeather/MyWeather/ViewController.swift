//
//  ViewController.swift
//  MyWeather
//
//  Created by DengJixiang on 16/6/21.
//  Copyright © 2016年 DengJixiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIAlertViewDelegate,UIActionSheetDelegate{
    var checkCity : String = "湛江"
    
    var cityEnterTextField: UITextField?
    
    var db:SQLiteDB!  //创建数据库
    
    var usernameTextField: UITextField?
    
    var passwordTextField: UITextField?
    
    var NewUsername : String = "" //新注册的用户
    
    var NewPassword : String = "" //新注册密码
    
    var txtUname: String = ""
    
    var txtPassword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadtheweather()
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
    //MARK:加载天气
    func addEncoding(st : String ) ->String? {
        if #available(iOS 7.0, OSX 10.9, *) {
            return st.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        }
        else {
            return  st.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        }
    }//这个函数目的是将GBK编码转为UTF-8编码
    
    func rmEncoding(st : String ) ->String? {
        if #available(iOS 7.0, OSX 10.9, *) {
            return  st.stringByRemovingPercentEncoding
        }
        else {
            return st.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        }
    }//将UTF-8编码转为GBK编码
    
    func loadtheweather(){
        let s1 = checkCity// 中文字符串
        let s2 = addEncoding(s1)!   // UTF8重编码
        
        var url = NSURL(string : "http://wthrcdn.etouch.cn/weather_mini?city=\(s2)")
        
        var data : NSData = NSData.init(contentsOfURL: url!)!
        
        var jason = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
        
        let info = jason?.objectForKey("data")
        
        let city = info?.objectForKey("city")
        
        let temp = info?.objectForKey("wendu")
        
        let tips = info?.objectForKey("ganmao")
        
        let forecast = info?.objectForKey("forecast")
        
        let todayDate = forecast![0]?.objectForKey("date")
        
        let todayWind = forecast![0]?.objectForKey("fengxiang")
        
        let todayWindSpeed = forecast![0]?.objectForKey("fengli")
        
        let todayWeather = forecast![0]?.objectForKey("type")
        
        let todayHtemp = forecast![0]?.objectForKey("high")
        
        let todayLtemp = forecast![0]?.objectForKey("low")
        
        let tomorrowDate = forecast![1]?.objectForKey("date")
        
        let tomorrowWind = forecast![1]?.objectForKey("fengxiang")
        
        let tomorrowWindSpeed = forecast![1]?.objectForKey("fengli")
        
        let tomorrowWeather = forecast![1]?.objectForKey("type")
        
        let tomorrowHtemp = forecast![1]?.objectForKey("high")
        
        let tomorrowLtemp = forecast![1]?.objectForKey("low")
        
        let afterTomorrowDate = forecast![2]?.objectForKey("date")
        
        let afterTomorrowWind = forecast![2]?.objectForKey("fengxiang")
        
        let afterTomorrowWindSpeed = forecast![2]?.objectForKey("fengli")
        
        let afterTomorrowWeather = forecast![2]?.objectForKey("type")
        
        let afterTomorrowHtemp = forecast![2]?.objectForKey("high")
        
        let afterTomorrowLtemp = forecast![2]?.objectForKey("low")
        
        let ThreeDayFromNowDate = forecast![3]?.objectForKey("date")
        
        let ThreeDayFromNowWind = forecast![3]?.objectForKey("fengxiang")
        
        let ThreeDayFromNowWindSpeed = forecast![3]?.objectForKey("fengli")
        
        let ThreeDayFromNowWeather = forecast![3]?.objectForKey("type")
        
        let ThreeDayFromNowHtemp = forecast![3]?.objectForKey("high")
        
        let ThreeDayFromNowLtemp = forecast![3]?.objectForKey("low")
        
        CityLabel.text = city as! String
        
        TodayWeatherLabel.text = todayWeather as! String
        
        TodayImage.image=UIImage(named: "\(todayWeather as! String)")!
        
        TodayTempLabel.text = temp as! String
        
        TodayWindLabel.text = todayWind as! String
        
        TodayWindSpeedLabel.text = todayWindSpeed as! String
        
        TomorrowDateLabel.text = tomorrowDate as! String
        
        TomorrowImage.image = UIImage(named: "\(tomorrowWeather as! String)")
        
        TomorrowHtempLabel.text = tomorrowHtemp as! String
        
        TomorrowLtempLabel.text = tomorrowLtemp as! String
        
        TomorrowWindLabel.text = tomorrowWind as! String
        
        TomorrowWindSpeedLabel.text = tomorrowWindSpeed as! String
        
        afterTomorrowDateLabel.text = afterTomorrowDate as! String
        
        afterTomorrowImage.image = UIImage(named: "\(afterTomorrowWeather as! String)")
        
        afterTomorrowHtempLabel.text = afterTomorrowHtemp as! String
        
        afterTomorrowLtempLabel.text = afterTomorrowLtemp as! String
        
        afterTomorrowWindLabel.text = afterTomorrowWind as! String
        
        afterTomorrowWindSpeedLabel.text = afterTomorrowWindSpeed as! String
        
        ThreeDayFromNowDateLabel.text = ThreeDayFromNowDate as! String
        
        ThreeDayFromNowImage.image = UIImage(named: "\(ThreeDayFromNowWeather as! String)")
        
        ThreeDayFromNowHtempLabel.text = ThreeDayFromNowHtemp as! String
        
        ThreeDayFromNowLtempLabel.text = ThreeDayFromNowLtemp as! String
        
        ThreeDayFromNowWindLabel.text = ThreeDayFromNowWind as! String
        
        ThreeDayFromNowWindSpeedLabel.text = ThreeDayFromNowWindSpeed as! String
        
        Tips.text = "Tips: \(tips as! String)"

    }
    
    @IBOutlet weak var CityLabel: UILabel!
    
    @IBOutlet weak var TodayWeatherLabel: UILabel!
    
    @IBOutlet weak var TodayImage: UIImageView!
    
    @IBOutlet weak var TodayTempLabel: UILabel!
    
    @IBOutlet weak var TodayWindLabel: UILabel!
    
    @IBOutlet weak var TodayWindSpeedLabel: UILabel!
    
    @IBOutlet weak var TomorrowDateLabel: UILabel!
    
    @IBOutlet weak var TomorrowImage: UIImageView!
    
    @IBOutlet weak var TomorrowHtempLabel: UILabel!
    
    @IBOutlet weak var TomorrowLtempLabel: UILabel!
    
    @IBOutlet weak var TomorrowWindLabel: UILabel!
    
    @IBOutlet weak var TomorrowWindSpeedLabel: UILabel!
    
    @IBOutlet weak var afterTomorrowDateLabel: UILabel!
    
    @IBOutlet weak var afterTomorrowImage: UIImageView!
    
    @IBOutlet weak var afterTomorrowHtempLabel: UILabel!
    
    @IBOutlet weak var afterTomorrowLtempLabel: UILabel!
    
    @IBOutlet weak var afterTomorrowWindLabel: UILabel!
    
    @IBOutlet weak var afterTomorrowWindSpeedLabel: UILabel!
    
    @IBOutlet weak var ThreeDayFromNowDateLabel: UILabel!
    
    @IBOutlet weak var ThreeDayFromNowImage: UIImageView!
    
    @IBOutlet weak var ThreeDayFromNowHtempLabel: UILabel!
    
    @IBOutlet weak var ThreeDayFromNowLtempLabel: UILabel!
    
    @IBOutlet weak var ThreeDayFromNowWindLabel: UILabel!
    
    @IBOutlet weak var ThreeDayFromNowWindSpeedLabel: UILabel!
    
    @IBOutlet weak var Tips: UITextView!
    
    @IBOutlet weak var showUser: UILabel!
    
    //Mark:切换城市
    @IBAction func ChangeCity() {
        let alertController = UIAlertController(title: "切换城市", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        
        //添加文本框
        alertController.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.placeholder = "请输入城市名"
            self.cityEnterTextField = textField
           
        }
        
        
        
        //创建取消按钮
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: { (action:UIAlertAction) -> Void in
            
            print("取消")
        })
        
        //创建确定按钮
        let otherAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction) -> Void in
            
            print("确定")
            print(self.checkCity)
            self.checkCity = self.cityEnterTextField!.text!
            self.loadtheweather()
            
        })
        
        
        //添加按钮
        alertController.addAction(cancelAction)
        alertController.addAction(otherAction)
        
        //弹出
        self.presentViewController(alertController, animated: true, completion: { () -> Void in
            
        })

    }
    //Mark:用户登录
    @IBAction func gotoLogin(sender: UIButton)  {
        let alertController = UIAlertController(title: "登录", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        
        //添加文本框
        alertController.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.placeholder = "登录"
        }
        
        //添加文本框1
        alertController.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.placeholder = "密码"
            textField.secureTextEntry = true
        }
        
        
        //创建取消按钮
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: { (action:UIAlertAction) -> Void in
            
            print("取消")
        })
        
        //创建确定按钮
        let enterAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction) -> Void in            
            print("确定")
            self.checkUser()
        })
        
        //创建注册按钮
        let signInAction = UIAlertAction(title: "注册", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction) -> Void in
            print("注册")
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
                //Mark:注册成功提醒
                //创建单一按钮提醒视图
                let oneButtonAlert:UIAlertView = UIAlertView(title: "提示", message: "注册成功，欢迎使用！", delegate: nil, cancelButtonTitle: "确定")
                //显示提醒视图
                oneButtonAlert.show()
                
                //设置提醒视图样式
                oneButtonAlert.alertViewStyle = UIAlertViewStyle.LoginAndPasswordInput
                
            })
            
            
            //添加按钮
            alertController.addAction(cancelAction)
            alertController.addAction(otherAction)
            
            //弹出
            self.presentViewController(alertController, animated: true, completion: { () -> Void in
                
            })

            
        })
        
        //添加按钮
        
        alertController.addAction(cancelAction)
        alertController.addAction(signInAction)
        alertController.addAction(enterAction)
        
        //弹出
        self.presentViewController(alertController, animated: true, completion: { () -> Void in
            
        })
        
        
    }
    
    //Mark:登出
    
    @IBAction func lognOut(sender: AnyObject) {
        txtUname = ""
        
        txtPassword = ""
        self.showUser.hidden = true
        
    }
    
    //Mark:操作数据库
    //从SQLite加载数据
    func initUser() {
        let data = db.query("select * from t_user")
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            self.txtUname = (user["uname"] as? String)!
            self.txtPassword = (user["password"] as? String)!
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
        print(txtUname)  //调试用
        print(txtPassword)  //调试用
        let selectData = "select uname,password from t_user where uname = '\(txtUname)'"  //将用户输入的用户名在数据库中查询
        let data = db.query(selectData)
        var row = data[0]  //查询得到的数据存入数组待用
        if let name = row["uname"]{
            print(row["password"]!)
            let getPassword = row["password"]
            if txtPassword == row["password"]! as! String {
                //判断密码是否正确
                print("Welcome!")
                //Mark:登录成功
                let oneButtonAlert:UIAlertView = UIAlertView(title: "提醒", message: "登录成功", delegate: nil, cancelButtonTitle: "确定")
                //显示提醒视图
                oneButtonAlert.show()
                
                //设置提醒视图样式
                oneButtonAlert.alertViewStyle = UIAlertViewStyle.LoginAndPasswordInput
                
                //Mark:页面跳转
                let mainStoryboard = UIStoryboard(name: "Main",bundle:NSBundle.mainBundle())  //注意name的storyboard不能出错，否则无法跳转
                self.showUser.text = "欢迎\(name)"
                self.showUser.hidden = false
                
                row = data[0]
            }
            else {
                print("Invalid password,please check out!")
                //Mark：登录失败
                let oneButtonAlert:UIAlertView = UIAlertView(title: "提醒", message: "用户名或密码错误，请确认后输入", delegate: nil, cancelButtonTitle: "确定")
                //显示提醒视图
                oneButtonAlert.show()
                
                //设置提醒视图样式
                oneButtonAlert.alertViewStyle = UIAlertViewStyle.LoginAndPasswordInput
                
                
            }
            
        }
        print(selectData)
    }


}

