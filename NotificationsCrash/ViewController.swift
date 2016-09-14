//
//  ViewController.swift
//  NotificationsCrash
//
//  Created by Pavel Belder on 14/09/2016.
//  Copyright © 2016 Medisafe. All rights reserved.
//

import UIKit
import UserNotifications


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func boomClicked(sender: AnyObject) {
        
        for j in 0...10 {
        
        
            self.clearAllNotifications()
            
            let now =  self.resetSeconds(NSDate())
            self.scheduleNotification(forDate: now.dateByAddingTimeInterval(60), id:"\(j)")
            
            for i in 1...21{
                
                let minuteFromNow = now.dateByAddingTimeInterval(Double(60*60*i))
                self.scheduleNotification(forDate: minuteFromNow, id:"\(j)\(i)" )
                
            }
        }
        
        
        for j in 0...10 {
            
            self.clearAllNotifications()

            let now =  self.resetSeconds(NSDate())
            self.scheduleNotification(forDate: now.dateByAddingTimeInterval(120),id:"x\(j)")
            
            for i in 1...21{
                
                let minuteFromNow = now.dateByAddingTimeInterval(Double(60*60*i))
                self.scheduleNotification(forDate: minuteFromNow,id:"x\(j)\(i)")
                
            }
        }
        
    }
    
    
    func scheduleNotification(forDate actualItemDate:NSDate , id:String){
        
        
        for i in 0...3{
            
            
            
            let alarmDate = actualItemDate.dateByAddingTimeInterval(NSTimeInterval (60 * 10 * i))
            
            let unitFlags: NSCalendarUnit = [.Hour, .Minute , .Second , .Day, .Month, .Year]
            
            let components = NSCalendar.currentCalendar().components(unitFlags, fromDate: alarmDate)
            
            let calendarTrigger = UNCalendarNotificationTrigger(dateMatchingComponents: components, repeats: false)
            
            let content = UNMutableNotificationContent()
            content.title = "Need to choose a title"
            content.subtitle = "Need to choose a subtitle"
            content.body = "some body"
            content.badge = 0
            content.sound = UNNotificationSound.defaultSound()
            
            let requestIdentifier = id
            let request = UNNotificationRequest(identifier: requestIdentifier,content: content,trigger: calendarTrigger)
            
            UNUserNotificationCenter.currentNotificationCenter().addNotificationRequest(request) { (error) in

            }
            
        }
    }

    func clearAllNotifications(){

        UNUserNotificationCenter.currentNotificationCenter().removeAllPendingNotificationRequests()

        
    }
    

     func resetSeconds(date: NSDate) -> NSDate {
        
        let cal = NSCalendar.currentCalendar()

        let priorComponents = cal.components([NSCalendarUnit.Weekday , NSCalendarUnit.Year , NSCalendarUnit.Month , NSCalendarUnit.Day , NSCalendarUnit.Hour , NSCalendarUnit.Minute , NSCalendarUnit.Second], fromDate: date)
        let newComponents = cal.components([NSCalendarUnit.Weekday , NSCalendarUnit.Year , NSCalendarUnit.Month , NSCalendarUnit.Day , NSCalendarUnit.Hour , NSCalendarUnit.Minute], fromDate: date)
        newComponents.year = priorComponents.year
        newComponents.month = priorComponents.month
        newComponents.day = priorComponents.day
        newComponents.second = 0
        newComponents.minute = priorComponents.minute
        newComponents.hour = priorComponents.hour
        
        return cal.dateFromComponents(newComponents)!
    }
}

