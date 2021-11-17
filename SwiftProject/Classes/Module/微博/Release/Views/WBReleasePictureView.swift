//
//  WBReleasePictureView.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/16.
//

import UIKit
import DKImagePickerController

class WBReleaseAddPictureCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let iconView = UIImageView()
        iconView.image = UIImage.init(named: "compose_pic_add")
        iconView.contentMode = .scaleAspectFill
        iconView.layer.masksToBounds = true
        contentView.addSubview(iconView)
        
        iconView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class WBReleasePictureCell: UICollectionViewCell {
    private var _asset: DKAsset?
    
    private var iconView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        iconView.contentMode = .scaleAspectFill
        iconView.layer.masksToBounds = true
        contentView.addSubview(iconView)
        
        iconView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    var asset: DKAsset? {
        get {
            return _asset
        }
        set {
            _asset = newValue
            guard let ass = _asset else { return }
            guard let showImage = ass.showImage else {
                ass.fetchOriginalImage(options: .none) { image, info in
                    ass.showImage = image
                    self.iconView.image = image
                }
                return
            }
            self.iconView.image = showImage
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class WBReleasePictureView: UIView {
    
    weak var delegate: WBReleasePictureViewDelegate?
    
    fileprivate let itemMargin: CGFloat = 10
    fileprivate var itemWH = (SCREEN_WIDTH - 30 - 20)/3
    
    fileprivate var _assets: [DKAsset] = []
    
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: itemWH, height: itemWH)
        
        let collect = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collect.delegate = self
        collect.dataSource = self
        collect.register(WBReleasePictureCell.self, forCellWithReuseIdentifier: "WBReleasePictureCell")
        collect.register(WBReleaseAddPictureCell.self, forCellWithReuseIdentifier: "WBReleaseAddPictureCell")
        
        return collect
    }()
    
    var observer: NSKeyValueObservation?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        observer = collectionView.observe(\.contentSize, options: [.old, .new]) { (collectionView, change) in
            let old = CGFloat(change.oldValue?.height ?? 0)
            let new = CGFloat(change.newValue?.height ?? 0)
            if old != new {
                self.snp.updateConstraints { make in
                    make.height.equalTo(new)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    var assets: [DKAsset] {
        get {
            _assets
        }
        set {
            _assets = newValue
            collectionView.reloadData()
        }
        
    }

}



// 代理
protocol WBReleasePictureViewDelegate: NSObjectProtocol {
    //
    func addPicture(pictureView: WBReleasePictureView,assets: [DKAsset])
    func deletePicture(pictureView: WBReleasePictureView,assets: [DKAsset])
}


extension WBReleasePictureView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        if cell is WBReleaseAddPictureCell {
            delegate?.addPicture(pictureView: self, assets: _assets)
            return
        }
    }
}

extension WBReleasePictureView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if _assets.count > 0 && _assets.count < 9 {
            return _assets.count + 1
        }
        return _assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == _assets.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WBReleaseAddPictureCell", for: indexPath)
            return cell
        }
        let cell: WBReleasePictureCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WBReleasePictureCell", for: indexPath) as! WBReleasePictureCell
        cell.asset = _assets[indexPath.row]
        return cell
    }
    
    
}
