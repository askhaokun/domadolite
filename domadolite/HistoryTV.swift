//
//  HistoryTV.swift
//  domadolite
//
//  Created by Hawken Zhao on 12/26/14.
//  Copyright (c) 2014 Hawken Zhao. All rights reserved.
//

import UIKit

class HistoryTV: UITableView, UITableViewDataSource, UITableViewDelegate{
    
//    required init(coder aDecoder: (NSCoder!)){
//        super.init(coder: aDecoder)
//        self.dataSource = self
//        self.delegate = self
//    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }

    required init(coder aDecoder: (NSCoder!)) {
        super.init(coder: aDecoder)
        self.dataSource = self
        self.delegate = self

    }
    
//    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
//        return 1
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : AnyObject! = tableView.dequeueReusableCellWithIdentifier("cell")
        
        var label = cell.viewWithTag(0) as UILabel
        var label1 = cell.viewWithTag(1) as UILabel
        label.text = "hahah"
        label1.text = "hohoh"
        
        return cell as UITableViewCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

}
