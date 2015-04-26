//
//  TodayViewController.swift
//  HSEToday
//
//  Created by Sergey Pronin on 4/21/15.
//  Copyright (c) 2015 Sergey Pronin. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var tableFlights: UITableView!
    
    let flights = Flight.allFlights()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.preferredContentSize = CGSize(width: 320,
            height: 100)
        
        tableFlights.delegate = self
        tableFlights.dataSource = self
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        
        completionHandler(NCUpdateResult.NewData)
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        
        return defaultMarginInsets
        
    }
}


extension TodayViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FlightCell") as! UITableViewCell
        
        let label = cell.viewWithTag(1) as! UILabel
        
        let flight = flights[indexPath.row]
        
        label.text = "\(flight.airline.code) \(flight.number)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let flight = flights[indexPath.row]
        
        let url = NSURL(string: "hseproject://flight?number=\(flight.number)&airline=\(flight.airline.code)")!
        
        self.extensionContext!.openURL(url,
            completionHandler: nil)
        
    }
}
