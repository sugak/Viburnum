//
//  ConversationViewController.swift
//  Viburnum
//
//  Created by Maksim Sugak on 24/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import UIKit

class ConversationViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.tableView.dataSource = self
          
      self.tableView.separatorStyle = .none // Убираем стандартный разделитель
      navigationController?.navigationBar.prefersLargeTitles = true // Увеличиваем шрифт в тайтле навбара
      tableView.rowHeight = UITableView.automaticDimension
      tableView.estimatedRowHeight = 44
    
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return sampleMessages.count
    }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellID = sampleMessages[indexPath.row].incomingMessage ? "incomeCell" : "outcomeCell"
    
    let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! messageViewCell
    cell.textMess = sampleMessages[indexPath.row].text
   
    /*
    if indexPath.row == numberOfSections(in: tableView) {
      cell.textMess = lastMessage[indexPath.section][indexPath.row]
    }
     */
    return cell

    }
    
    
  }


