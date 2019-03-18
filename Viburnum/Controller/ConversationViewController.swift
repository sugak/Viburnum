//
//  ConversationViewController.swift
//  Viburnum
//
//  Created by Maksim Sugak on 24/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import UIKit
// , ManagerDelegate
class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var blabberChat: Blabber! // user for data transfer
 // var blabberID: String!
  @IBOutlet var tableView: UITableView!
  @IBOutlet var messageInputField: UITextField!
  
  @IBAction func sendMessageButton(_ sender: UIButton) {
    let messageToSend = messageInputField.text
    print(messageToSend ?? "empty")
    
    CommunicationManager.shared.multiPeerCommunicator.sendMessage(string: messageToSend!, to: blabberChat.id) { success, error in
      if success {
        self.messageInputField.text = ""
      }
      if let error = error {
        print(error.localizedDescription)
        self.view.endEditing(true)
        let alert = UIAlertController(title: "Ошибка при отправке сообщения", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
      }
    }
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
  
  func globalUpdate() {
    tableView.reloadData()
  }
  
  // Tableview functions:
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Rows number as in array:
    return blabberChat.message.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Choosing between cell prototype:
    var cellID = ""
    if blabberChat.messageType[indexPath.row] == .income {
      cellID = "incomeCell"
    } else {
      cellID = "outcomeCell"
    }
    let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! messageViewCell
    cell.textMess = blabberChat.message[indexPath.row]
    return cell
  }
}



