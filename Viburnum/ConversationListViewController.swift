//
//  ConversationListViewController.swift
//  Viburnum
//
//  Created by Maksim Sugak on 22/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import UIKit

class ConversationListViewController: UITableViewController {
  
  let sections = ["Online","History"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
  }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
      // Считаем количество записей для каждой секции (вроде правильно)
      let onlineNumber = ifOnline.filter{$0}.count
      let offlineNumber = ifOnline.count - onlineNumber
      let numberOfRowsInSectionsArray = [onlineNumber, offlineNumber]
      print(onlineNumber)
      print(offlineNumber)
      return numberOfRowsInSectionsArray[section]
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "conversationСell", for: indexPath) as! ConversationListTableViewCell
      
      if indexPath.section == 0 {
        if ifOnline[indexPath.row] {
      cell.name = talkerNames[indexPath.row]
      cell.message = lastMessages[indexPath.row]
      cell.online = ifOnline[indexPath.row]
      cell.hasUnreadMessages = ifMessageUnread[indexPath.row]
        }
      } else {
        cell.name = talkerNames[indexPath.row]
        cell.message = lastMessages[indexPath.row]
        cell.online = ifOnline[indexPath.row]
        cell.hasUnreadMessages = ifMessageUnread[indexPath.row]
      }
        return cell
    }
  
  func implementCell (forSection: Int, forRow: Int) {
    
  }
  

}
