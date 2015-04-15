//
//  FlightsViewController.swift
//  HSEProject
//
//  Created by Sergey Pronin on 3/27/15.
//  Copyright (c) 2015 Sergey Pronin. All rights reserved.
//

import UIKit

class FlightsViewController: UITableViewController {
    
    var flights = [Flight]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        flights = Flight.allFlights()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCellWithIdentifier("FlightCell", forIndexPath: indexPath) as! FlightCell

        let flight = flights[indexPath.row]
        
        cell.labelAirlineName.text = flight.airline.name
        cell.labelFlightName.text = "\(flight.airline.code) \(flight.number)"

        return cell
    }

}
