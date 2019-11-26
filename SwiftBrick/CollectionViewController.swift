//
//  CollectionViewController.swift
//  SwiftBrick
//
//  Created by iOS on 19/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit

class CollectionViewController: JHCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prefersNavigationBarHidden = false
        self.mainDatas = [["","","","","","","",""],["","","","","","",""],["","","","","","","","","","",""],["","","","","","","","","",""]]
        // Do any additional setup after loading the view.
        JHCollectionReusableView.registerHeaderFooterView(collectionView: self.collectionView!, viewType: .SectionHeader)
        JHCollectionReusableView.registerHeaderFooterView(collectionView: self.collectionView!, viewType: .SectionFooter)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 200, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = JHCollectionReusableView.dequeueReusableHeaderFooterView(collectionView: collectionView, viewType: .SectionHeader, indexPath: indexPath)
            header.backgroundColor = .purple
            return header
        default:
            let footer = JHCollectionReusableView.dequeueReusableHeaderFooterView(collectionView: collectionView, viewType: .SectionHeader, indexPath: indexPath)
            footer.backgroundColor = .yellow
            return footer
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: SCREEN_WIDTH, height: 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: SCREEN_WIDTH, height: 60)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = JHCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        cell.backgroundColor = .random
        return cell
    }
}
