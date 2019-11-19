//
//  JHBaseCollectionViewController.swift
//  JHToolsModule_Swift
//
//  Created by iOS on 18/11/2019.
//  Copyright © 2019 HU. All rights reserved.
//

import UIKit

class JHCollectionViewController: JHViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    public enum ScrollDirectionType {
        case ScrollVertical
        case ScrollHorizontal
    }
    
    public var collectionView : UICollectionView?
    public var mainDatas : Array<Any> = []
    public var scrollDirectionType : ScrollDirectionType = .ScrollVertical
    public var flowLayout : UICollectionViewFlowLayout?
    
    public convenience init(scrollDirectionType: ScrollDirectionType = .ScrollVertical) {
        self.init()
        
        self.configFlowLayout()
        switch scrollDirectionType {
        case .ScrollHorizontal:
            self.flowLayout?.scrollDirection = UICollectionView.ScrollDirection.horizontal
            break
        default:
            self.flowLayout?.scrollDirection = UICollectionView.ScrollDirection.vertical
            break
        }
    }
    
    func configFlowLayout() {
        self.flowLayout = UICollectionViewFlowLayout.init()
        self.flowLayout?.minimumLineSpacing = 0
        self.flowLayout?.minimumInteritemSpacing = 0
        self.flowLayout?.minimumLineSpacing = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard self.flowLayout != nil else {
            self.configFlowLayout()
            self.flowLayout?.scrollDirection = UICollectionView.ScrollDirection.vertical
            return
        }
        
        self.collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: self.flowLayout!)
        self.collectionView?.backgroundColor = .clear
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell.init()
    }
    
}
