//
//  HistoryViewController.swift
//  domadolite
//
//  Created by Hawken Zhao on 12/27/14.
//  Copyright (c) 2014 Hawken Zhao. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {
    
    
    
    //  var dataArr:Array<AnyObject> = []
    
    @IBOutlet weak var HistoryText: UITextView!
    
    @IBAction func datePicker(sender: AnyObject) {
        let pickedDate = sender.date
        fetchData(pickedDate!!)
            }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(NSDate())
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData(pickedDate: NSDate) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        var f = NSFetchRequest (entityName: "Missionjournal")
        var dataArr = context!.executeFetchRequest(f, error: nil)!
        
        var outputText = ""
        println(dataArr.count)
        
        var index = 0
        for index = 0; index < dataArr.count; index++ {
            var dateout: String = dataArr[index].valueForKey("date") as String
            var timeout: String = dataArr[index].valueForKey("time") as String
            var missionout: String = dataArr[index].valueForKey("mission") as String
            var durationout: Int = dataArr[index].valueForKey("duration") as Int
            var completed: Bool = dataArr[index].valueForKey("complete") as Bool
            println("\(dateout)")
            ////            println("\(index)")
            ////            println("\(dateFormatter.stringFromDate(pickedDate!!))")
            if (dateFormatter.stringFromDate(pickedDate)) == dateout {
                //////                //outputText += dateFormatter.stringFromDate(pickedDate!!)
                outputText += dateout
                outputText += " at " + timeout
                outputText += ": "
                outputText += missionout
                outputText += " for \(durationout)"
                outputText += " secs \n"
                if completed{
                    outputText += "Mission Complete\n"
                }
                else{
                    outputText += "Mission Failed\n"
                }
            }
        }
        HistoryText.text = outputText

    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
