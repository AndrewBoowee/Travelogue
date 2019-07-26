//
//  ViewController.swift
//  Travelogue
//
//  Created by Drew Boowee on 7/26/19.
//  Copyright © 2019 Drew Boowee. All rights reserved.
//

import UIKit
import CoreData

class TripViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tripTitleTextField: UITextField!
    @IBOutlet weak var tripDescriptionTextBox: UITextView!
    
    var trips = [Trip]()
    
    override func viewWillAppear(_ animated: Bool) {
        viewTrips()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripC", for: indexPath)
        
        let trip = trips[indexPath.row]
        cell.textLabel?.text = trip.name
        
        return cell
    }
    

    @IBOutlet weak var tripTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Trips"
        tripTableView.dataSource = self as!
            tripTableView.delegate = self as! <#type#>
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addTrips(_ sender: Any) {
        let alert = UIAlertController(title: "Add Trip", message: "Enter new title.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Submit", style: UIAlertAction.Style.default, handler: {
            (alertAction) -> Void in
            if let textField = alert.textFields?[0], let name = textField.text
            {
                let Name = name.trimmingCharacters(in: .whitespaces)
                if (Name == "")
                {
                    self.alertNotifyUser(message: "Error, give proper name")
                    return
                }
                self.addTrip(name: Name)
            } else {
                self.alertNotifyUser(message: "Error, cannot use this name")
                return
        }
        }))
      
        self.present(alert, animated: true, completion: nil)
    }
    
    func viewTrips() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
        
        do {
            trips = try managedContext.fetch(fetchRequest)
            
            tripsTableView.reloadData()
        }
        catch
        {
            print("Could not get trips")
        }
    }
    
    func deleteTrip(at indexPath: IndexPath) {
        let trip = trips[indexPath.row]
        
        if let managedObjectContext = trip.managedObjectContext {
            managedObjectContext.delete(trip)
            
            do {
                try managedObjectContext.save()
                self.trips.remove(at: indexPath.row)
                tripTableView.deleteRows(at: [indexPath], with: .automatic)
            }
            catch
            {
                print("Delete failed: \(error).")
                tripTableView.reloadData()
            }
        }
    }
    
    func confirmDeleteTrip(at indexPath: IndexPath)
    {
        let trip = trips[indexPath.row]
        
        if let entries = trip.entries, entries.count > 0
        {
            let title = trip.title ?? "Trip"
            // Alert user to delete the Trip if the Trip contains any Entries
            let alert = UIAlertController(title: "Delete Trip", message: "\(title) contains entries. Do you want to delete it?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.destructive, handler:
            {
                (alertAction) -> Void in
                self.deleteTrip(at: indexPath)
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
        else
        {
            deleteTrip(at: indexPath)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EntryViewController,
            let row = tripTableView.indexPathForSelectedRow?.row {
            destination.trip = trips[row]
        }
    }
    
//    func adding Trip(name: String) {
//        let trip = Trip(name: name)
//        if let trip = trip {
//            do {
//                let managedObjectContext = trip.managedObjectContext
//                try managedObjectContext?.save()
//            }
//    }
    
    @IBAction func saveTrip(_ sender: Any) {
        guard let tripTitle = tripTitleTextField.text, let tripDescription = tripDescriptionTextBox.text else {
            print("Choose a title for trip")
            return
            }
        
        let trip = Trip(title: tripTitle, contents: tripDescription)
        
        do {
            try trip?.managedObjectContext?.save()
            self.navigationController?.popViewController(animated: true)
            }
            catch
            {
            print("Error")
        }
}




