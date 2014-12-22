//
//  ViewController.swift
//  domadolite
//
//  Created by Hawken Zhao on 12/22/14.
//  Copyright (c) 2014 Hawken Zhao. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var txtMission: UITextField!
    
    @IBOutlet weak var lbRemainingTime: UILabel!
    
    @IBAction func btn25Min(sender: AnyObject) {
        remainingSeconds = 25*60
        isCounting = true
    }
    
    @IBAction func btn3Sec(sender: AnyObject) {
        remainingSeconds = 3
        isCounting = true
    }
    
    var remainingSeconds: Int = 0 {
        willSet(newSeconds) {
            
            let mins = newSeconds / 60
            let seconds = newSeconds % 60
            
            lbRemainingTime!.text = NSString(format: "%02d:%02d", mins, seconds)
            
            if newSeconds <= 0 {
                isCounting = false
            }
        }
    }
    
    var timer: NSTimer?
    var isCounting: Bool = false {
        willSet(newValue) {
            if newValue {
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
            } else {
                timer?.invalidate()
                timer = nil
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTimer(sender: NSTimer) {
        remainingSeconds -= 1
        if remainingSeconds <= 0 {
            alert()
            recordHistory(txtMission.text!)
        }
    }
    
    func recordHistory(mission:String){
//Record in file
//        var sp = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
//        if sp.count > 0{
//            var url = NSURL(fileURLWithPath: "\(sp[0])/data.txt")!
//            println(url)
//            
//            var data = NSMutableData()
//            data.appendData("\(mission)".dataUsingEncoding(NSUTF8StringEncoding,allowLossyConversion: true)!)
//            //    data.writeToFile(url.path!, atomically: true)
//            //    data.appendData("Hello Swift1\n".dataUsingEncoding(NSUTF8StringEncoding,allowLossyConversion: true)!)
//            data.writeToFile(url.path!, atomically: true)
//            println("end")
//        }

//Record in sqlite
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        
//        println(dateFormatter.stringFromDate(date))
//        println(timeFormatter.stringFromDate(date))
        
        var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        var row:AnyObject = NSEntityDescription.insertNewObjectForEntityForName("Missionjournal", inManagedObjectContext: context!)
        row.setValue("\(mission)", forKey:"mission")
        row.setValue(14, forKey:"duration")
        row.setValue(dateFormatter.stringFromDate(date), forKey:"date")
        row.setValue(timeFormatter.stringFromDate(date), forKey:"time")
        context!.save(nil)
        println("come on!")
    }
    
    func alert(){
        let msgAlert = UIAlertView()
        msgAlert.title = "计时完成！"
        msgAlert.message = ""
        msgAlert.addButtonWithTitle("OK")
        msgAlert.show()
    }
}

