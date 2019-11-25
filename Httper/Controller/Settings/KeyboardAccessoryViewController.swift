//
//  KeyboardAccessoryViewController.swift
//  Httper
//
//  Created by Meng Li on 2019/11/14.
//  Copyright © 2019 limeng. All rights reserved.
//

private struct Const {
    static let cellSize = CGSize(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
}

class KeyboardAccessoryViewController: BaseViewController<KeyboardAccessoryViewModel> {

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = Const.cellSize
            layout.minimumLineSpacing = 0
            layout.scrollDirection = .vertical
            return layout
        }())
        collectionView.register(cellType: KeyboardAccessoryCollectionViewCell.self)

        return collectionView
    }()
    
    private lazy var dataSource = KeyboardAccessoryCollectionViewCell.collectionViewSingleSectionDataSource(configureCell: { cell, indexPath, _ in
        cell.didRemove = { [unowned self] in
            self.viewModel.remove(at: indexPath.row)
        }
    })

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        createConstraints()
        
        disposeBag ~ [
            viewModel.characterSection ~> collectionView.rx.items(dataSource: dataSource)
        ]
        
    }

    private func createConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeArea.top)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
}
