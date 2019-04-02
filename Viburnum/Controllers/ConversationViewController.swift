//
//  ConversationViewController.swift
//  Viburnum
//
//  Created by Maksim Sugak on 24/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import UIKit
import CoreData

class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ManagerDelegate, UITextFieldDelegate {
  
  // User for data transfer:
  var blabberChat: Conversation!
  var fetchResultsController: NSFetchedResultsController<Message>!
  
  // Outlets:
  @IBOutlet var tableView: UITableView!
  @IBOutlet var sendButton: UIButton!
  @IBOutlet var messageInputField: UITextField!
  @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var customView: UIView!
  
  // Actions:
  
  @IBAction func messageInputFieldChanged(_ sender: Any) {
    if (messageInputField.text != "") && (blabberChat.isOnline) {
      sendButton.isEnabled = true
    } else {
      sendButton.isEnabled = false
    }
  }
  
  @IBAction func sendMessageButton(_ sender: UIButton) {
    let messageToSend = messageInputField.text
    let conversationId = blabberChat.conversationId
    messageInputField.resignFirstResponder()
    
    CommunicationManager.shared.multiPeerCommunicator.sendMessage(string: messageToSend!, to: conversationId!) { success, error in
      if success {
        self.messageInputField.text = ""
        self.sendButton.isEnabled = false
       // self.tableView.reloadData()
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
    messageInputField.clipsToBounds = true
    
    // Tuning keyboard:
    keyBoardSettings()
    
    //TextField delegate:
    messageInputField.delegate = self
    
    CommunicationManager.shared.delegate = self
    setupFRC()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    NotificationCenter.default.removeObserver(self)
   // clearChat()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.customView.superview?.setNeedsLayout()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(Constants.animated)
    blabberChat.hasUnreadMessages = false
 //   globalUpdate()
    
    // Initial sendButton state:
    sendButton.isEnabled = false
  }
  
  private func setupFRC() {
    guard let conversationId = blabberChat.conversationId else { return }
    fetchResultsController = NSFetchedResultsController(fetchRequest: FetchRequestsManager.shared.fetchMessagesFrom(conversationID: conversationId), managedObjectContext: CoreDataStack.shared.mainContext, sectionNameKeyPath: nil, cacheName: nil)
    fetchResultsController.delegate = self
    do {
      try fetchResultsController.performFetch()
    } catch {
    }
  }
  
  // Delegate funcntion:
  func globalUpdate() {
//    if !blabberChat.online {
//      // Cleaning messages:
//      clearChat()
//    }
    
    blabberChat.hasUnreadMessages = false
    tableView.reloadData()
    
    // Scroll down to the last message:
    scrollChatDown()
  }
  
//  func clearChat () {
//    sendButton.isEnabled = false
//    blabberChat.message.removeAll()
//    blabberChat.messageDate.removeAll()
//    blabberChat.messageType.removeAll()
//  }
  
  // Scroll down to the last message:
  func scrollChatDown() {
    guard let fetchedObjects = fetchResultsController.fetchedObjects else { return }
    if !fetchedObjects.isEmpty {
      let indexPath = IndexPath(row: fetchedObjects.count - 1, section: 0)
      tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
//    if blabberChat.messages?.count != 0 {
//      let indexPath = IndexPath(row: blabberChat.messages?.count ?? 0 - 1, section: 0)
//      tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//    }
  }
  
  
  // Tableview functions:
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let count = fetchResultsController.fetchedObjects?.count {
      return count
    } else {
        return 0
      }
    }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Choosing between cell prototype:
    let message = fetchResultsController.object(at: indexPath)
    var cellID = ""
    if message.isIncome {
      cellID = "incomeCell"
    } else {
      cellID = "outcomeCell"
    }
    let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! messageViewCell
    cell.textMess = message.text
    cell.textDate = message.date
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

extension ConversationViewController: NSFetchedResultsControllerDelegate {
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
    globalUpdate()
  }
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                  didChange anObject: Any, at indexPath: IndexPath?,
                  for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .delete:
      tableView.deleteRows(at: [indexPath!], with: .none)
    case .update:
      tableView.reloadRows(at: [indexPath!], with: .none)
    case .insert:
      tableView.insertRows(at: [newIndexPath!], with: .none)
    case .move:
      tableView.deleteRows(at: [indexPath!], with: .none)
      tableView.insertRows(at: [newIndexPath!], with: .none)
    }
  }
}




