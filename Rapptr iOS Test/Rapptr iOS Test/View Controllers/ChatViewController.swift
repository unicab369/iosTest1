//
//  ChatViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Using the following endpoint, fetch chat data
     *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
     *
     * 3) Parse the chat data using 'Message' model
     *
     **/
    
    // MARK: - Properties
    private var client: ChatClient?
    private var messages: [MessageItem] = []
    
    // MARK: - Outlets
    @IBOutlet weak var chatTable: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chat"
        
        configureTable(tableView: chatTable)
        self.loadMessages()
    }
    
    private func loadMessages() {
        DataService.shared.getMessages { [weak self] messages in
            guard let msgs = messages else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.messages = msgs
                self?.chatTable.reloadData()
            }
        }
    }
    
    // MARK: - Private
    private func configureTable(tableView: UITableView) {
        tableView.delegate = self
//        tableView.dataSource = self
        tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    // MARK: - IBAction
    @IBAction func backAction(_ sender: Any) {
//        let mainMenuViewController = MenuViewController()
//        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
}

//------------------------------------------------
// MARK: TableViewDataSource
//------------------------------------------------

//extension ChatViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell: ChatTableViewCell? = nil
//        if cell == nil {
//            let nibs = Bundle.main.loadNibNamed("ChatTableViewCell", owner: self, options: nil)
//            cell = nibs?[0] as? ChatTableViewCell
//        }
//    //        cell?.setCellData(message: messages[indexPath.row])
//        return cell!
//    }
//
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard let cell = cell as? ChatTableViewCell else { return }
//        cell.model = messages[indexPath.row]
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return messages.count
//    }
//
//}

//------------------------------------------------
// MARK: TableViewDelegate
//------------------------------------------------

extension ChatViewController: UITableViewDelegate {
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let target = messages[indexPath.row]
        let messageHeight = target.message.heightWithConstrainedWidth(width: self.view.frame.width-80, font: StyleFont.chatMessageFont)
        return 30 + messageHeight
    }
}
