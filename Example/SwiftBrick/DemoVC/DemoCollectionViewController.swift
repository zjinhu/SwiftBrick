//
//  CollectionViewController.swift
//  SwiftBrick
//
//  Created by iOS on 19/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit
import SnapKit
import Swift_Form
import SwiftBrick
class DemoCollectionViewController: CollectionViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prefersNavigationBarHidden = false
        
        mainDatas = [["","","","","","","",""],["","","","","","",""],["","","","","","","","","","",""],["","","","","","","","","",""]]
        
        ss.addRightBarButton(normalImage: .icon_back,
                          highLightImage: .icon_back,
                          fixSpace: 0) {_ in 
            print("touch")
        }
        
        ss.addRightBarButton(text: "Button",
                          normalColor: .darkGray,
                          highlightColor: .lightGray,
                          fixSpace: 0 ) {_ in 
            self.navigationController?.pushViewController(SwiftUIVC(SwiftUIView()), animated: true)
        }
        
        collectionView?.ss.registerHeaderFooterView(CollectionReusableView.self, kindType: .sectionHeader)
        collectionView?.ss.registerHeaderFooterView(CollectionReusableView.self, kindType: .sectionFooter)
        
        
        collectionView?.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let size = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(100)
            )
            
            let item = NSCollectionLayoutItem(layoutSize: size)
            
            //                let groupSize = NSCollectionLayoutSize(
            //                    widthDimension: .fractionalWidth(1),
            //                    heightDimension: .absolute(100)
            //                )
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            section.interGroupSpacing = 10
            // Supplementary header view setup
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(20)
            )
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            
            let footerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(20)
            )
            let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: footerSize,
                elementKind: UICollectionView.elementKindSectionFooter,
                alignment: .bottom
            )
            
            section.boundarySupplementaryItems = [sectionHeader,sectionFooter]
            return section
        })
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.ss.dequeueReusableHeaderFooterView(CollectionReusableView.self, kindType: .sectionHeader, indexPath: indexPath)
            header.backgroundColor = .purple
            return header
        default:
            let footer = collectionView.ss.dequeueReusableHeaderFooterView(CollectionReusableView.self, kindType: .sectionFooter, indexPath: indexPath)
            footer.backgroundColor = .yellow
            return footer
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.ss.dequeueReusableCell(CollectionViewCell.self, indexPath: indexPath)
        cell.backgroundColor = .random
        return cell
    }
    
    
    
    ///ios13以下
    override func setupFlowLayout() -> UICollectionViewFlowLayout{
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.headerReferenceSize = CGSize.zero
        flowLayout.footerReferenceSize = CGSize.zero
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        return flowLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 150, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: Define.screenWidth, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: Define.screenWidth, height: 60)
    }
    
}
