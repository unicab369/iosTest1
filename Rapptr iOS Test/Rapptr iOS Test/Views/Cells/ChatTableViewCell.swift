//
//  ChatTableViewCell.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit
import Combine

class ChatTableViewCell: UITableViewCell {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Setup cell to match mockup
     *
     * 2) Include user's avatar image
     **/
    
    // MARK: - Outlets
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    private var cancellable: AnyCancellable?
    
    var model: MessageItem? {
        didSet {
            self.showIndicator(true)
            header.attributedText = model?.name.attributedString(withColor: StyleColor.black)
            body.attributedText = model?.message.attributedString(withColor: StyleColor.black)
            
            self.cancellable = loadImage(for: model)?.sink { [unowned self] image in
                self.iconView.image = image
                self.showIndicator(false)
            }
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = StyleColor.viewBackground
        self.body.numberOfLines = 0
        self.header.font = StyleFont.chatUserNameFont
        self.body.font = StyleFont.chatMessageFont
        
        iconView.layer.masksToBounds = false
        iconView.layer.cornerRadius = iconView.frame.size.width/2
        iconView.clipsToBounds = true
    }
    
    private func showIndicator(_ show: Bool) {
        self.indicator.isHidden = !show
        show ? self.indicator.startAnimating() : self.indicator.stopAnimating()
    }
    
    private func loadImage(for model: MessageItem?) -> AnyPublisher<UIImage?, Never>? {
        guard let thumbNail = model?.avatar_url, let url = URL(string: thumbNail) else { return nil }
        return Just(url)
        .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
            return ImageLoader.shared.loadImage(from: url)
        })
        .eraseToAnyPublisher()
    }
}
