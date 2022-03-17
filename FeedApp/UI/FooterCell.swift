//
//  FooterCell.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 10.02.2022.
//

import UIKit

class FooterCell: UITableViewCell {
    
    static public let identifier = "FooterCell"
    
    public let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.cornerRadius = 14
        view.layer.masksToBounds = true
        return view
    }()
    public let commentsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    public let commentsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPurple
        return button
    }()
    public let commentsCountLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemRed
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.text = "112"
        label.textAlignment = .center
        return label
    }()
    public let rateStackView: UIStackView = {
       let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.layer.cornerRadius = 15
        sv.layer.masksToBounds = true
        
        return sv
    }()

    public let upvoteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPurple
        return button
    }()
    public let rateLabel: UILabel = {
        let label = UILabel()
        label.text = "21.3k"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.backgroundColor = .systemRed
        return label
    }()
    public let downvoteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPurple
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    func setupViews() {
        contentView.addSubview(mainView, layoutAnchors: [
            .bottom(0),
            .top(0),
            .leading(15),
            .trailing(-15)
        ])
        //
        //  commentsStackView
        //
        
        mainView.addSubview(commentsStackView, layoutAnchors: [
            .leading(10),
            .centerY(0),
            .relative(attribute: .height, relation: .equal, relatedTo: .height, multiplier: 0.6, constant: 0)
        ])
        commentsStackView.activate(layoutAnchors: [
            .relative(attribute: .width, relation: .equal, relatedTo: .height, multiplier: 2, constant: 0)
        ], to: commentsStackView)
        
        commentsStackView.addArrangedSubview(commentsButton)
        commentsStackView.addArrangedSubview(commentsCountLabel)
        //
        //  rateStackView
        //
        
        mainView.addSubview(rateStackView, layoutAnchors: [
            .centerY(0),
            .trailing(-10)
        ])
        
        
        rateStackView.activate(layoutAnchors: [
            .relative(attribute: .height, relation: .equal, relatedTo: .height, multiplier: 1, constant: 0),
            .relative(attribute: .width, relation: .equal, relatedTo: .width, multiplier: 3, constant: 0)
        ], to: commentsButton)
        
        rateStackView.addArrangedSubview(downvoteButton)
        rateStackView.addArrangedSubview(rateLabel)
        rateStackView.addArrangedSubview(upvoteButton)
    }
}
