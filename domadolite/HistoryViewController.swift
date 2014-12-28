//
//  HistoryViewController.swift
//  domadolite
//
//  Created by Hawken Zhao on 12/27/14.
//  Copyright (c) 2014 Hawken Zhao. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class HistoryViewController: UIViewController {

   
    @IBOutlet weak var HistoryText: UITextView!
    
    @IBAction func datePicker(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let pickedDate = sender.date
        HistoryText.text = dateFormatter.stringFromDate(pickedDate!!)

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData(){
        var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        var f = NSFetchRequest (entityName: "Missionjournal")
        context?.executeFetchRequest(f, error: nil)
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
