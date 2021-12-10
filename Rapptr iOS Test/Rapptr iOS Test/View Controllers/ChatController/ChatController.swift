//
//  LoginController.swift
//  Rapptr iOS Test
//
//  Created by The Alchemist on 12/9/21.
//

import Foundation
import UIKit

class ChatController: UIViewController {
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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "ChatView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Outlets
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    // MARK: - Actions
    @IBAction func backButtonTapped(_ sender: Any) {
        self.onReturn?()
    }
    
    // MARK: - Properties
    var onReturn: (()->Void)?
    private var client: ChatClient?
    private var messages: [MessageItem] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMessages()
    }
    
    private func setup() {
        backButton.tintColor = .white
        topView.backgroundColor = StyleColor.blue
        topLabel.font = StyleFont.headerFont
        topLabel.attributedText = "Chat".attributedString(withColor: StyleColor.white)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = StyleColor.viewBackground
        tableView.separatorColor = .clear
    }
    
    private func loadMessages() {
        DataService.shared.getMessages { [weak self] messages in
            guard let msgs = messages else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.messages = msgs
                self?.tableView.reloadData()
            }
        }
    }
}


// MARK: - TableViewDataSource
extension ChatController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - TableViewDelegate
extension ChatController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as? ChatTableViewCell
        cell?.model = messages[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let target = messages[indexPath.row]
        let messageHeight = target.message.heightWithConstrainedWidth(width: self.view.frame.width-50, font: StyleFont.chatMessageFont)
        return 70 + messageHeight
    }
}


