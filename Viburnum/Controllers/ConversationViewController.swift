//
//  ConversationViewController.swift
//  Viburnum
//
//  Created by Maksim Sugak on 24/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ManagerDelegate, UITextFieldDelegate {
  
  // User for data transfer:
  var blabberChat: Blabber!
  
  // Outlets:
  @IBOutlet var tableView: UITableView!
  @IBOutlet var sendButton: UIButton!
  @IBOutlet var messageInputField: UITextField!
  @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var customView: UIView!
  
  // Actions:
  
  @IBAction func messageInputFieldChanged(_ sender: Any) {
    if messageInputField.text != "" {
      sendButton.isEnabled = true
    } else {
      sendButton.isEnabled = false
    }
  }
  @IBAction func sendMessageButton(_ sender: UIButton) {
    let messageToSend = messageInputField.text
    messageInputField.resignFirstResponder()
    
    CommunicationManager.shared.multiPeerCommunicator.sendMessage(string: messageToSend!, to: blabberChat.id) { success, error in
      if success {
        self.messageInputField.text = ""
        self.tableView.reloadData()
      }
      if let error = error {
        self.view.endEditing(true)
        let alert = UIAlertController(title: "Ошибка при отправке сообщения: \(error.localizedDescription)", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: Constants.animated, completion: nil)
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
    
    // Tuning message input field:
   // messageInputField.layer.cornerRadius = 10.0
    messageInputField.clipsToBounds = true
    
    // Tuning keyboard:
    keyBoardSettings()
    
    //TextField delegate:
    messageInputField.delegate = self

  }
  
  override func viewWillDisappear(_ animated: Bool) {
    NotificationCenter.default.removeObserver(self)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.customView.superview?.setNeedsLayout()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(Constants.animated)
    blabberChat.hasUnreadMessages = false
    CommunicationManager.shared.delegate = self
    globalUpdate()
    
    // Initial sendButton state:
    sendButton.isEnabled = false
  }
  
  // Delegate funcntion:
  func globalUpdate() {
    if !blabberChat.online {
      sendButton.isEnabled = false
    }
    blabberChat.hasUnreadMessages = false
    tableView.reloadData()
    
    // Scroll down to the last message:
    scrollChatDown()
  }
  
  // Scroll down to the last message:
  func scrollChatDown() {
    if blabberChat.message.count != 0 {
      let indexPath = IndexPath(row: blabberChat.message.count - 1, section: 0)
      tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
  }
  
  
  // Tableview functions:
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Rows number as in array:
    return blabberChat?.message.count ?? 0
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
    cell.textDate = blabberChat.messageDate[indexPath.row]
    return cell
  }
  
  func keyBoardSettings() {
    // Keyboard notifications:
    NotificationCenter.default.addObserver(forName: UIWindow.keyboardWillShowNotification, object: nil, queue: nil) { (nc) in
      self.view.frame.origin.y = -270
      // Scroll down to the last message:
      self.scrollChatDown()
    }
    NotificationCenter.default.addObserver(forName: UIWindow.keyboardWillHideNotification, object: nil, queue: nil) { (nc) in
      self.view.frame.origin.y = 0.0
      // Scroll down to the last message:
      self.scrollChatDown()
    }
  }
  
  // Hide keyboard on textView Return tap:
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if string == "\n"
    {
      sendMessageButton(sendButton)
      messageInputField.resignFirstResponder()
      // Scroll down to the last message:
      scrollChatDown()
      return true
    }
    return true
  }
}



