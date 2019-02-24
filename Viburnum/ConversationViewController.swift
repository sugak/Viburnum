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
          self.tableView.separatorStyle = .none // Убираем стандартный разделитель
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    switch indexPath.row {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: "incomeMessageCell", for: indexPath) as! messageViewCell
      cell.incomeMessageLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
      return cell
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: "outcomeMessageCell", for: indexPath) as! messageViewCell
      cell.outcomeMessageLabel.text = "Lorem ipsum dolor sit amet"
      return cell
    case 2:
      let cell = tableView.dequeueReusableCell(withIdentifier: "incomeMessageCell", for: indexPath) as! messageViewCell
      cell.incomeMessageLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua "
      return cell
    default:
      return UITableViewCell()
    }
    
    
  }

}
