//
//  HashtagSuggestionViewController.swift
//  StampAll
//
//  Created by Дмитро  on 11.08.2022.
//

import AppKit

protocol HasthagCompletionViewControllerDelegate: AnyObject {
    func tapHashtagCompletion(string: String)
}


class HashtagSuggestionViewController: NSViewController {
    @IBOutlet  weak var tableView: NSTableView!
    
    var hashtag = Hashtag()
    
    weak var delegate: HasthagCompletionViewControllerDelegate?
    
    init() {
        super.init(nibName:  NSNib.Name("HashtagSuggestionViewController"), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HashtagSuggestionViewController: NSTableViewDelegate {
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard tableView.selectedRow != -1 else { return }
        let row = tableView.selectedRow
        let hashtag = hashtag.hashtagsArray[row]
        print(hashtag)
    }
}

extension HashtagSuggestionViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        hashtag.hashtagsArray.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "hashtag") , owner: self) as? HashtagSuggestionTableViewCell else {
            return nil
        }
        
        let hashtag = hashtag.hashtagsArray[row]
        cell.hashtagNameLabel.stringValue = "\(hashtag)"
        return cell
    }
}

