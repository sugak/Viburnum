//
//  ConversationViewController.swift
//  Viburnum
//
//  Created by Maksim Sugak on 24/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet var tableView: UITableView!
  @IBOutlet var messageInputField: UITextField!
  @IBAction func sendMessageButton(_ sender: UIButton) {
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    // Remove separator:
    self.tableView.separatorStyle = .none
    
    // Making large navbar title:
    navigationController?.navigationBar.prefersLargeTitles = true
    
    // Tuning row height:
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 44
    
  }
  
  // Tableview functions:
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Rows number as in array:
    return sampleMessages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Choosing between cell prototype:
    let cellID = sampleMessages[indexPath.row].incomingMessage ? "incomeCell" : "outcomeCell"
    let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! messageViewCell
    cell.textMess = sampleMessages[indexPath.row].text
    return cell
  }
}



