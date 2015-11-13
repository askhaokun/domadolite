//
//  ViewController.swift
//  domadolite
//
//  Created by Hawken Zhao on 12/22/14.
//  Copyright (c) 2014 Hawken Zhao. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtMission: UITextField!
    
    @IBOutlet weak var lbRemainingTime: UILabel!
    
    @IBOutlet weak var txtMin: UITextField!
    
    @IBOutlet weak var btn25out: UIButton!
    
    @IBOutlet weak var btn3out: UIButton!
    
    @IBOutlet weak var btnAbout: UIButton!
    
    @IBOutlet weak var btnHisout: UIButton!
    
    @IBAction func txtMissionAssign(sender: AnyObject) {
        txtMission.text = ""
    }
    
    
    @IBAction func btn25Min(sender: AnyObject) {
        remainingSeconds = 25*60
        durationSeconds = remainingSeconds
        setCountdown()
        isCounting = true
    }
    
    @IBAction func btn3Sec(sender: AnyObject) {
        if txtMin.text == ""{
            alert("Input Minutes First!")
        }
        else{
            remainingSeconds =  (Int(txtMin.text!)!) * 60
            durationSeconds = remainingSeconds
            setCountdown()
            isCounting = true
        }
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
            
            lbRemainingTime!.text = NSString(format: "%02d:%02d", mins, seconds) as String
            
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
        resetCd()
        txtMission.delegate = self
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
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let row:AnyObject = NSEntityDescription.insertNewObjectForEntityForName("Missionjournal", inManagedObjectContext: context!)
        row.setValue("\(mission)", forKey:"mission")
        row.setValue(duration, forKey:"duration")
        row.setValue(dateFormatter.stringFromDate(startTime), forKey:"date")
        row.setValue(timeFormatter.stringFromDate(startTime), forKey:"time")
        row.setValue(complete, forKey:"complete")
        do {
            try context!.save()
        } catch _ {
        }
        print("come on!")
    }
    
    func setCountdown(){
        txtMission.enabled = false
        txtMission.alpha = 0.6
        txtMin.enabled = false
        txtMin.alpha = 0.6
        btn25out.enabled = false
        btn3out.enabled = false
        btnAbout.enabled = true
        btnHisout.enabled = false
        
        UIApplication.sharedApplication().idleTimerDisabled = true
    }
    
    func resetCd(){
        txtMission.enabled = true
        txtMission.alpha = 1
        txtMin.enabled = true
        txtMin.alpha = 1
        btn25out.enabled = true
        btn3out.enabled = true
        btnAbout.enabled = false
        btnHisout.enabled = true
        
        UIApplication.sharedApplication().idleTimerDisabled = false
    }
    
    func alert(content:String){
        let msgAlert = UIAlertView()
        msgAlert.title = "\(content)"
        msgAlert.message = ""
        msgAlert.addButtonWithTitle("OK")
        msgAlert.show()
        resetCd()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        self.view.endEditing(true)
    }

    
}

