//
//  LinkCell.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 11.02.2022.
//

import UIKit

final class LinkCell: UITableViewCell {

    static let identifier: String = "LinkCell"
    
    var delegate: LinkOpenerDelegate?
    
    var urlString: String = ""
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private var heightConstraint: NSLayoutConstraint?
    
    let preview: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .orange
        iv.layer.cornerRadius = 12
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = false
        iv.isUserInteractionEnabled = true //Отвечает за доступ к событиям
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private let titleBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    
    let domainTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 10, weight: .semibold)

        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    func setupPreviewHeight(_ height: CGFloat) {
        heightConstraint?.constant = height
    }
    func setupPreviewImage(_ image: UIImage?) {
        preview.image = image
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        backgroundColor = .clear
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(previewPressed))
        preview.addGestureRecognizer(recognizer)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        backgroundColor = .clear
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(previewPressed))
        preview.addGestureRecognizer(recognizer)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        preview.image = nil
    }
    private func setupViews() {
        
        contentView.addSubview(mainView, layoutAnchors: [
            .top(0),
            .bottom(0),
            .leading(15),
            .trailing(-15)
        ])
        mainView.addSubview(preview, layoutAnchors: [
            .top(10),
            .bottom(-10),
            .leading(10),
            .trailing(-10)
        ])
        heightConstraint = NSLayoutConstraint(item: preview, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        heightConstraint?.isActive = true
        heightConstraint?.priority = .defaultHigh
        preview.addSubview(titleBackground, layoutAnchors: [
            .bottom(0),
            .leading(0),
            .trailing(0)
        ])
        titleBackground.activate(layoutAnchors: [
            .relative(attribute: .height, relation: .equal, relatedTo: .notAnAttribute, multiplier: 1, constant: 25)
        ], to: nil)
        titleBackground.addSubview(domainTitle, layoutAnchors: [
            .bottom(0),
            .top(0),
            .leading(10),
            .trailing(-10)
        ])
    }
    
    @objc func previewPressed(sender: AnyObject) {
        guard let url = URL(string: urlString), let delegate = delegate else {
            return
        }
        delegate.openLink(url: url)
    }
    
}
