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
    self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 0.3333333333, green: 0.6196078431, blue: 0.3333333333, alpha: 1)
    
    // Extra alertController to set current date:
    let askingForDateAlert = UIAlertController(title: "Привет!", message: "Неизвестно, когда вы будете проверять задание, поэтому предлагаю обновить дату в крайнем сообщении на сегодняшнюю, чтобы проверить задание со звёздочкой. Делаем?", preferredStyle: .alert)
    let cancelButton = UIAlertAction(title: "Не, не надо.", style: .cancel, handler: nil)
    let confirmButton = UIAlertAction(title: "Да!", style: .default, handler: {(action) in
      
      let taskFormatter  = DateFormatter()
      taskFormatter.dateFormat = "dd.MM.yyyy HH:mm"
      let currentDate = Date()
      let result = taskFormatter.string(from: currentDate)

      stringDate[0][0] = result
      self.tableView.reloadData()
    })
    
    askingForDateAlert.addAction(confirmButton)
    askingForDateAlert.addAction(cancelButton)
    
    present(askingForDateAlert, animated: Constants.animated, completion: nil)
    }
  
  // Tableview functions:
    override func numberOfSections(in tableView: UITableView) -> Int {
      // As in array:
        return sections.count
    }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     // As in array:
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
  // Segute to chat:
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showConversation" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let destinationController = segue.destination as!
        ConversationViewController
        
        // Transfer name into navbar:
        let cell = tableView.cellForRow(at: indexPath) as! ConversationListTableViewCell
        destinationController.navigationItem.title = cell.name
      }
    }
  }
}
