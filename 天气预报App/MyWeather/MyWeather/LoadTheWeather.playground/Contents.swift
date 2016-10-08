//: Playground - noun: a place where people can play

import UIKit

//load weather


func addEncoding(st : String ) ->String? {
    if #available(iOS 7.0, OSX 10.9, *) {
        return st.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
    }
    else {
        return  st.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
    }
}


func rmEncoding(st : String ) ->String? {
    if #available(iOS 7.0, OSX 10.9, *) {
        return  st.stringByRemovingPercentEncoding
    }
    else {
        return st.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
    }
}

var checkCity : String = "珠海"

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











