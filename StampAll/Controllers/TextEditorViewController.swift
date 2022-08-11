//
//  TextEditorViewController.swift
//  StampAll
//
//  Created by Дмитро  on 11.08.2022.
//

import AppKit

class TextEditorViewController: NSViewController {
    @IBOutlet  weak var textView: NSTextView!
    @IBOutlet  weak var timeStampButton: NSButton!
    
    var lastHashtagSymbolPosition: Int?
    
    var hashtagSuggestionVC: HashtagSuggestionViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHashtagSuggestionVC()
        
        textView.delegate = self
    }
    
    func setupHashtagSuggestionVC() {
        hashtagSuggestionVC = HashtagSuggestionViewController()
        //        hashtagSuggestionVC?.view.wantsLayer = true
        //        hashtagSuggestionVC?.view.layer?.cornerRadius = 10
        //        hashtagSuggestionVC?.view.layer?.shadowRadius = 5
    }
    
    func addText(_ text: String) {
        let attributedString = NSAttributedString(string: " \n\(text) \n")
        textView.textStorage?.append(attributedString)
        textView.linkTextAttributes = [
            .foregroundColor: NSColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
    }
    
    func pastImageToTextView(_ image: NSImage?) {
        let image = image
        let attach = NSTextAttachment()
        attach.image = image
        
        let attrString = NSAttributedString(attachment: attach)
        textView.textStorage?.append(attrString)
    }
    
    @IBAction func getTimestampAndImagePreview(_ sender: NSButton) {
        addButton()
    }
    
    func addButton() {
        let attacmentCell = NSTextAttachmentCell(textCell: "oksdffdslfkjlkj")
        //        attacmentCell.
        let attacment = NSTextAttachment()
        attacment.attachmentCell = attacmentCell
        let attrString = NSAttributedString(attachment: attacment)
        print("KYKY",attrString.string)
        textView.textStorage?.append(attrString)
    }
    
    
    
    
    //    func imagePreview(from moviePath: URL, in seconds: Double) -> NSImage? {
    //        let timestamp = CMTime(seconds: seconds, preferredTimescale: 60)
    //        let asset = AVURLAsset(url: moviePath)
    //        let generator = AVAssetImageGenerator(asset: asset)
    //        generator.maximumSize = CGSize(width: 120, height: 0)
    //
    //        generator.appliesPreferredTrackTransform = true
    //
    //        guard let imageRef = try? generator.copyCGImage(at: timestamp, actualTime: nil) else {
    //            return nil
    //        }
    //        return NSImage(cgImage: imageRef, size: .zero)
    //    }
    
    
    private func checkIfTextViewContains(_ string: String) {
        let range = textView.selectedRange()
        let rect = textView.firstRect(forCharacterRange: range, actualRange: nil)
        
        let newRect = textView.convert(rect, from: nil)
        
        //        let newRect = view.convert(rect, to: textView)
        
        
        
        if textView.string.last == Character(string) {
            hashtagSuggestionVC?.view.frame = NSRect(
                x: newRect.maxX,
                y: newRect.maxY,
                width: 200,
                height: 150)
            
            hashtagSuggestionVC?.view.identifier = NSUserInterfaceItemIdentifier("hashtag")
            
            
            textView.addSubview(hashtagSuggestionVC!.view)
        } else  {
            for view in textView.subviews where view.identifier!.rawValue == "hashtag" {
                view.removeFromSuperview()
            }
        }
    }
}


// MARK: - NSTextViewDelegate
extension TextEditorViewController : NSTextViewDelegate {
    func textViewDidChangeSelection(_ notification: Notification) {
        
        let range = textView.selectedRange()
        let text = textView.string
        // print(String(Array(text)[sRange]))
        let tx = text.startIndex...
        print("result",text[tx])
        
        if textView.string.last == "#" {
            lastHashtagSymbolPosition = textView.selectedRange().location
            print(lastHashtagSymbolPosition)
        }
        
        
        
        checkIfTextViewContains("#")
    }
}

