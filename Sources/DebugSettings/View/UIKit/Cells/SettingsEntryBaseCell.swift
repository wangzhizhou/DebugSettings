//
//  SettingsEntryBaseCell.swift
//  
//
//  Created by joker on 2022/10/28.
//

import UIKit

class SettingsEntryBaseCell: UITableViewCell {
    
    lazy var icon = UIImageView()
    
    lazy var titleLabel: UILabel = {
        let ret = UILabel()
        ret.textColor = .black
        ret.font = .boldSystemFont(ofSize: 16)
        return ret
    }()
    
    lazy var subtitleLabel: UILabel = {
        let ret = UILabel()
        ret.textColor = .gray
        ret.font = .systemFont(ofSize: 12)
        ret.numberOfLines = 0
        return ret
    }()
    
    lazy var detailDescriptionLabel: UILabel = {
        let ret = UILabel()
        ret.textColor = .gray
        ret.font = .systemFont(ofSize: 8)
        ret.numberOfLines = 0
        return ret
    }()
    
    lazy var settingSwitch: UISwitch = {
        let ret = UISwitch(frame: CGRect(x: 0, y: 0, width: 36, height: 24))
        ret.addTarget(self, action: #selector(switchAction), for: .valueChanged)
        return ret
    }()
    
    lazy var rightArrowIcon: UIImageView = {
        let ret = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        ret.tintColor = .gray.withAlphaComponent(0.3)
        ret.image = UIImage(systemName: "chevron.right")
        ret.contentMode = .scaleAspectFit
        return ret
    }()
    
    let rightContainer = UIView()
    
    lazy var bottomLine: UIView = {
        let ret = UIView()
        ret.backgroundColor = .gray.withAlphaComponent(0.1)
        return ret
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .white
        
        self.contentView.addSubview(self.icon)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.subtitleLabel)
        self.contentView.addSubview(self.detailDescriptionLabel)
        self.contentView.addSubview(self.rightContainer)
        self.contentView.addSubview(self.bottomLine)
        
        self.icon.snp.makeConstraints { make in
            make.top.left.equalTo(self.contentView).offset(5)
            make.width.equalTo(self.icon.snp.height)
            make.height.equalTo(0)
        }

        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.icon)
            make.left.equalTo(self.icon.snp.right).offset(5)
            make.right.equalTo(self.self.rightContainer.snp.left).offset(-5)
        }
        
        self.subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(2)
            make.left.equalTo(self.contentView).offset(5)
            make.right.equalTo(self.titleLabel)
        }
        
        self.detailDescriptionLabel.snp.makeConstraints { make in
            make.left.right.equalTo(self.subtitleLabel)
            make.top.equalTo(self.subtitleLabel.snp.bottom).offset(2)
            make.bottom.equalTo(self.bottomLine.snp.top).offset(-5)
        }
        
        self.rightContainer.snp.makeConstraints { make in
            make.right.equalTo(self.contentView).offset(-5)
            make.centerY.equalTo(self.contentView)
            make.width.equalTo(0)
        }
        
        self.bottomLine.snp.makeConstraints { make in
            make.left.equalTo(self.icon)
            make.right.equalTo(self.rightContainer)
            make.height.equalTo(0.5)
            make.bottom.equalTo(self.contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var entryItem: SettingsEntryItem? = nil
    func bindEntryItem(_ entryItem: SettingsEntryItem) {
        self.entryItem = entryItem
        
        if let imageName = entryItem.icon, let iconImage = UIImage(systemName: imageName) {
            self.icon.image = iconImage
            self.icon.snp.updateConstraints { make in
                make.height.equalTo(self.titleLabel.snp.height)
            }
            self.titleLabel.snp.updateConstraints { make in
                make.left.equalTo(self.icon.snp.right).offset(5)
            }
        } else {
            self.icon.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
            self.titleLabel.snp.updateConstraints { make in
                make.left.equalTo(self.icon.snp.right).offset(0)
            }
        }
        
        self.titleLabel.text = entryItem.title
        self.subtitleLabel.text = entryItem.subtitle
        self.detailDescriptionLabel.text = entryItem.detailDescription
        
        
        self.rightContainer.subviews.forEach { $0.removeFromSuperview() }
        switch entryItem.type {
        case .switch:
            self.rightContainer.addSubview(self.settingSwitch)
            self.settingSwitch.snp.makeConstraints { make in
                make.edges.equalTo(self.rightContainer)
            }
            self.rightContainer.snp.updateConstraints { make in
                make.width.equalTo(self.settingSwitch.frame.size.width)
            }
            self.settingSwitch.isOn = entryItem.isSwitchOn ?? false
        case .subpage:
            self.rightContainer.addSubview(self.rightArrowIcon)
            self.rightArrowIcon.snp.makeConstraints { make in
                make.edges.equalTo(self.rightContainer)
            }
            self.rightContainer.snp.updateConstraints { make in
                make.width.equalTo(self.rightArrowIcon.frame.size.width)
            }
        default:
            break
        }
        
    }
    
    @objc func switchAction(_ sender: UISwitch) {
        self.entryItem?.isSwitchOn = sender.isOn
    }
}
