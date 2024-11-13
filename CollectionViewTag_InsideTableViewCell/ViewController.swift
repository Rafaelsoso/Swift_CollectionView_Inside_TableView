//
//  ViewController.swift
//  CollectionViewTag_InsideTableViewCell
//
//  Created by anh.nguyen3 on 13/11/24.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private properties
    var cellDatas: [(title: String, tags: [String])] = [
        ("Table Cell 0", ["tag 0"]),
        ("Table Cell 1", ["tag 1"]),
        ("Table Cell 2", ["tag 1", "tag 2"]),
        ("Table Cell 3", ["tag 1", "tag 2", "tag 3"]),
        ("Table Cell 4", ["tag 1", "tag 2", "tag 3", "tag 4"]),
        ("Table Cell 5", ["tag 1", "tag 2", "tag 3", "tag 4", "tag 5"]),
        ("Table Cell 6", ["tag 1", "tag 2", "tag 3", "tag 4", "tag 5", "tag 6"]),
        ("Table Cell 7", ["tag 1", "tag 2", "tag 3", "tag 4", "tag 5", "tag 6", "tag 7"]),
        ("Table Cell 8", ["tag 1", "tag 2", "tag 3", "tag 4", "tag 5", "tag 6", "tag 7", "tag 8"]),
        ("Table Cell 9", ["tag 1", "tag 2", "tag 3", "tag 4", "tag 5", "tag 6", "tag 7", "tag 8", "tag 9"]),
        ("Table Cell 10", ["tag 1", "tag 2", "tag 3", "tag 4", "tag 5", "tag 6", "tag 7", "tag 8", "tag 9", "tag 10"])
    ]
    var tagColletions: [Int: [String]] = [:]
    var sampleTags = ["tag 1, tag 2, tag 3"]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? Cell else {
            return UITableViewCell()
        }
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .blue.withAlphaComponent(0.3)
        } else {
            cell.backgroundColor = .white
        }
        cell.collectionView.tag = indexPath.row
        tagColletions[cell.collectionView.tag] = cellDatas[indexPath.row].tags
        cell.collectionView.dataSource = self
        let layout = TagFlowLayout()
        layout.estimatedItemSize = CGSize(width: 140, height: 40)
        layout.minimumInteritemSpacing = 14.0
        layout.minimumLineSpacing = 8.0
        cell.collectionView.collectionViewLayout = layout
        cell.didheightConstraintUpdated = {
            DispatchQueue.main.async {[weak self] in
                self?.tableView.beginUpdates()
                self?.tableView.endUpdates()
            }
        }
        cell.reloadData()
        return cell
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView.tag < cellDatas.count {
            return 1
        } else {
            return 0
        }
        //return (tagColletions[collectionView.tag] ?? []).isEmpty ? 0 : 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag < cellDatas.count {
            return cellDatas[collectionView.tag].tags.count
        } else {
            return 0
        }
//       return tagColletions[collectionView.tag]?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionCell", for: indexPath) as? TagCollectionCell else {
            return TagCollectionCell()
        }
        if collectionView.tag < cellDatas.count {
            let title = cellDatas[collectionView.tag].tags[indexPath.row]
            cell.title.text = title
        }
        //            let title = tagColletions[collectionView.tag]?[indexPath.row]
        //            cell.title.text = title
        cell.title.preferredMaxLayoutWidth = collectionView.frame.width - 40 // 40: horizontal padding
        return cell
    }
}
