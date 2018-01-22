//
//  TravelViewController.swift
//  TravelingSalesman
//
//  Created by Dennis Broekhuizen on 22-01-18.
//  Copyright © 2018 Dennis Broekhuizen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class TravelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var sectionTitles: [String] = ["Routes"]
    var routes: [Route] = []
    
    // Refrence to leaderboard table in database.
    let ref = Database.database().reference(withPath: "users")
    
    let userID = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let routesRef = ref.child(self.userID!).child("routes")
        
        routesRef.observe(.value, with: { snapshot in
            // Create array for new items in database.
            var newRoutes: [Route] = []
            
            for item in snapshot.children {
                // Declare and append elements from database to array
                let route = Route(snapshot: item as! DataSnapshot)
                newRoutes.append(route)
            }
            
            // Set new items to items array
            self.routes = newRoutes
            self.tableView.reloadData()
        })
        
        // Remove row seperator line for unfilled rows.
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routeCell", for: indexPath) as! RouteCell
        let loadedRoutes = routes[indexPath.row]

        cell.routeLabel.text = loadedRoutes.name

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return sectionTitles[section]
        } else {
            return nil
        }
    }
    
    // Pass data to next viewController.
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        if segue.identifier == "showRoute" {
            let routeDetailViewController = segue.destination as! RouteDetailViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedRoute = routes[indexPath.row]
            routeDetailViewController.chosenRoute = selectedRoute
        }
    }
    
}
