//
//  CollectionViewController.swift
//  SwiftBrick
//
//  Created by iOS on 19/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit

class CollectionViewController: JHCollectionViewController {

    override func setupFlowLayout() -> UICollectionViewFlowLayout{
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        return flowLayout
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prefersNavigationBarHidden = false
        self.mainDatas = [["","","","","","","",""],["","","","","","",""],["","","","","","","","","","",""],["","","","","","","","","",""]]
        // Do any additional setup after loading the view.
        addRightBarButton(normalImage: UIImage.init(named: "nav_ic_back"),
                          highLightImage: UIImage.init(named: "nav_ic_back"),
                          fixSpace: 3) {
            print("touch")
        }

        addRightBarButton(text: "54634535",
                          normalColor: .darkGray,
                          highlightColor: .lightGray,
                          fixSpace: 3) {
            print("123123")
        }
        
        self.collectionView?.registerHeaderFooterView(JHCollectionReusableView.self, kindType: .sectionHeader)
        self.collectionView?.registerHeaderFooterView(JHCollectionReusableView.self, kindType: .sectionFooter)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 200, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableHeaderFooterView(JHCollectionReusableView.self, kindType: .sectionHeader, indexPath: indexPath)
            header.backgroundColor = .purple
            return header
        default:
            let footer = collectionView.dequeueReusableHeaderFooterView(JHCollectionReusableView.self, kindType: .sectionFooter, indexPath: indexPath)
            footer.backgroundColor = .yellow
            return footer
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: ScreenWidth, height: 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: ScreenWidth, height: 60)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(JHCollectionViewCell.self, indexPath: indexPath)
        cell.backgroundColor = .random
        return cell
    }
}
