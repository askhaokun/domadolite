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
        durationSeconds = remainingSeconds
        isCounting = true
    }
    
    @IBAction func btn3Sec(sender: AnyObject) {
        remainingSeconds = 3
        durationSeconds = remainingSeconds
        isCounting = true
    }
    
    @IBAction func btnAbortMission(sender: AnyObject) {
        isCounting = false
        recordHistory(txtMission.text!, duration: (durationSeconds - remainingSeconds), complete: false)
        alert("任务取消")
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
    
    var durationSeconds: Int = 0
    
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
           alert("计时完成")
            recordHistory(txtMission.text! , duration: durationSeconds, complete: true)
        }
    }
    
    func recordHistory(mission:String, duration:Int, complete:Bool){
////////Record in file
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

///////Record in sqlite
        let date = NSDate()
        let startTime = date.dateByAddingTimeInterval(-Double(duration))
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        
//        println(dateFormatter.stringFromDate(date))
//        println(timeFormatter.stringFromDate(date))
        
        var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        var row:AnyObject = NSEntityDescription.insertNewObjectForEntityForName("Missionjournal", inManagedObjectContext: context!)
        row.setValue("\(mission)", forKey:"mission")
        row.setValue(duration, forKey:"duration")
        row.setValue(dateFormatter.stringFromDate(startTime), forKey:"date")
        row.setValue(timeFormatter.stringFromDate(startTime), forKey:"time")
        row.setValue(complete, forKey:"complete")
        context!.save(nil)
        println("come on!")
    }
    
    func alert(content:String){
        let msgAlert = UIAlertView()
        msgAlert.title = "\(content)"
        msgAlert.message = ""
        msgAlert.addButtonWithTitle("OK")
        msgAlert.show()
    }
}

