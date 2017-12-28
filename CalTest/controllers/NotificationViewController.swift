//
//  NotificationViewController.swift
//  CalTest
//
//  Created by Jamie McAllister on 29/11/2017.
//  Copyright © 2017 Jamie McAllister. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class NotificationViewController: UITableViewController {

    var requests: [Request] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notifications"
        
        
        
        tableView.register(NotificationRequestViewCell.self, forCellReuseIdentifier: "request")
        tableView.rowHeight = 150
        
    }
    
    func loadData(){
        
        let cal = CalendarHandler()
        requests = []
        cal.getRequests(forUser: (AccessToken.current?.userId)!, completion: { (request) in
            
            self.requests = request
            let calHandler = CalendarHandler()
            
            for request in self.requests{
                
                calHandler.doGraph(request: "/" + String(request.sender), params: "id, first_name, last_name, picture", completion: {(data) in
                    
                    
                    let picture = data["picture"]!
                    var pict = picture as! Dictionary<String, Any>
                    let pic = pict["data"] as! Dictionary<String, Any>
                    let person = Person(id: data["id"] as! String, first: data["first_name"] as! String, last: data["last_name"] as! String, picture: pic)
                    
                    request.person = person
                    
                    self.tabBarItem.badgeValue = String(self.requests.count)
                    person.downloadImage(url: URL(string: (person.link))!, table: self.tableView)
                    self.tableView.reloadData()
                })
            }
            
            
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return requests.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "request", for: indexPath) as! NotificationRequestViewCell
        
        let request = requests[indexPath.row]
        
        if let sender = request.person?.name{
            
            if let event = request.event.title{
        
                cell.title.text = sender + " would like to arrange '" + event + "' with you"
                cell.title.sizeToFit()
            }
            cell.timeLabel.text = "on " + (request.event.date)! + "-" + (request.event.month)! + "-" + (request.event.year)! + " at: " + (request.event.start)!
        }
        cell.id = request.id
        cell.table = self
        cell.pic.image = request.person?.picture
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }


}