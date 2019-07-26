//
//  EntryViewController.swift
//  Travelogue
//
//  Created by Drew Boowee on 7/26/19.
//  Copyright © 2019 Drew Boowee. All rights reserved.
//

import Foundation
import UIKit

class EntryViewController: UIViewController {
    
    @IBOutlet weak var entryImageView: UIImageView!
    @IBOutlet weak var entryTitleLabel: UILabel!
    @IBOutlet weak var entryDateLabel: UILabel!
    @IBOutlet weak var entryDescriptionLabel: UILabel!
    
    var trip: Trip?
    var entry: Entry?
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = trip?.name ?? ""
        
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        entryTableView.dataSource = self
        entryTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        update()
        entryTableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trip?.entries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        if let cell = cell as? EntryTableTableViewCell, let entry = trip?.entries?[indexPath.row] {
            cell.entryTitle.text = entry.title
            cell.entryImageView.image = entry.image
            if let date = entry.date {
                cell.entryDate.text = dateFormatter.string(from: date)
            }
        }
        
        return cell
    }
    
    func update() {
        entries = trip?.entries?.sortedArray(using: [NSSortDescriptor(key: "title", ascending: true)]) as? [Entry] ?? [Entry]()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? AddEntryViewController else {
            return
        }
        
        destination.trip = trip
        destination.entry = entry
}
}
