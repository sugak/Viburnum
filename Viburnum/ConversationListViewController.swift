//
//  ConversationListViewController.swift
//  Viburnum
//
//  Created by Maksim Sugak on 22/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import UIKit

class ConversationListViewController: UITableViewController {

  override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
      
      // Remove separator + large navbar title:
      self.tableView.separatorStyle = .none
      navigationController?.navigationBar.prefersLargeTitles = true
    
      self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 0.1578164101, green: 0.611730516, blue: 0.2583292723, alpha: 1)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
  }
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return TalkerName[section].count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "conversationСell", for: indexPath) as! ConversationListTableViewCell
      
      cell.name = TalkerName[indexPath.section][indexPath.row]
      cell.hasUnreadMessages = ifMessageUnread[indexPath.section][indexPath.row]
      cell.message = lastMessage[indexPath.section][indexPath.row]
      cell.online = ifOnline[indexPath.section][indexPath.row]
      cell.avatarSymbols = TalkerName[indexPath.section][indexPath.row]

      // Decoding date from String source:
      let formatter  = DateFormatter()
      formatter.dateFormat = "dd.MM.yyyy HH:mm"
      let messageDateFromString: Date?
      messageDateFromString = formatter.date(from: stringDate[indexPath.section][indexPath.row] ?? "nil")
      cell.date = messageDateFromString

      return cell
    }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showConversation" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let destinationController = segue.destination as!
        ConversationViewController
        let cell = tableView.cellForRow(at: indexPath) as! ConversationListTableViewCell
        destinationController.navigationItem.title = cell.name
      }
    }
  }
}
