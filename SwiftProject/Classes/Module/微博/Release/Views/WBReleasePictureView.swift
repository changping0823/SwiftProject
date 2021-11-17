//
//  WBReleasePictureView.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/16.
//

import UIKit
import DKImagePickerController


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
    
    fileprivate let itemMargin: CGFloat = 10
    fileprivate var itemWH = (SCREEN_WIDTH - 30 - 20)/3
    
    fileprivate var _assets: [DKAsset] = []
    
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize.init(width: itemWH, height: itemWH)
        
        
        let collect = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collect.backgroundColor = UIColor.color(r: 242, g: 242, b: 242)
        collect.delegate = self
        collect.dataSource = self
        collect.register(WBReleasePictureCell.self, forCellWithReuseIdentifier: "WBReleasePictureCell")
        return collect
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
//        let addAsset = DKAsset.addAssets()
//        _assets.append(addAsset)
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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



extension WBReleasePictureView: UICollectionViewDelegate{
    
}

extension WBReleasePictureView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        _assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WBReleasePictureCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WBReleasePictureCell", for: indexPath) as! WBReleasePictureCell
        cell.asset = _assets[indexPath.row]
        return cell
    }
    
    
}
