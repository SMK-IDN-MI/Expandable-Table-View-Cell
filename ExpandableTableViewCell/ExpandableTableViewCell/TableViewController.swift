//
//  ViewController.swift
//  ExpandableTableViewCell
//
//  Created by Farras Doko on 15/05/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    var items = [SubCell]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // init the items
        DispatchQueue.global().async {
            let cellData = SubCell(title: "This is Title", subTitle: ["Subtitle 1","Subtitle 2","Subtitle 3"], isOpen: false)
            for _ in 0..<10 {
                self.items.append(cellData)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        items.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard items[section].isOpen else {
            return 1
        }
        // show the title and the subtitle.
        return items[section].subTitle.count + 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "onlyCell", for: indexPath) as UITableViewCell
        if indexPath.row == 0 {
            cell.textLabel?.text = items[indexPath.row].title
            cell.backgroundColor = .red
            cell.textLabel?.textColor = .white
        } else {
            cell.textLabel?.text = items[indexPath.section].subTitle[indexPath.row - 1]
            cell.backgroundColor = .clear
            cell.textLabel?.textColor = .black
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.section].isOpen = !items[indexPath.section].isOpen
        let section = IndexSet(integer: indexPath.section)
        tableView.reloadSections(section, with: .automatic)
    }

}

