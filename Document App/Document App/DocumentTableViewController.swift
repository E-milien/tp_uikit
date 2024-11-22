//
//  DocumentTableViewController.swift
//  Document App
//
//  Created by Émilien on 11/18/2024.
//

import UIKit
import QuickLook

class DocumentTableViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var listImage: [[DocumentFile]] = [[DocumentFile](), [DocumentFile]()]
    let previewController = QLPreviewController()
    var filterdata: [[DocumentFile]]!
    
    struct DocumentFile {
        var title: String
        var size: Int
        var imageName: String? = nil
        var url: URL
        var type: String
        
        static var generateData = [
            DocumentFile(title: "img4.jpg", size: 4186341, imageName: nil, url: URL(string: "file:///path/img4.jpg")!, type: "public.jpeg"),
            DocumentFile(title: "img3.jpg", size: 1670268, imageName: nil, url: URL(string: "file:///path/img3.jpg")!, type: "public.jpeg"),
            DocumentFile(title: "img2.jpg", size: 1985695, imageName: nil, url: URL(string: "file:///path/img2.jpg")!, type: "public.jpeg"),
            DocumentFile(title: "img1.jpg", size: 7039737, imageName: nil, url: URL(string: "file:///path/img1.jpg")!, type: "public.jpeg"),
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDocument))
        self.loadAllDocumentFile()
        filterdata = listImage
    }
    
    @objc func addDocument() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.jpeg, .png])
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .overFullScreen
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true)
    }
    
    func loadAllDocumentFile() {
        let fm = FileManager.default
        let path = fm.urls(for: .documentDirectory, in: .userDomainMask).first!.path
        let items = try! fm.contentsOfDirectory(atPath: path)
        var documentList = [DocumentFile]()
        
        for item in items {
            let currentUrl = URL(fileURLWithPath: path + "/" + item)
            let resourcesValues = try! currentUrl.resourceValues(forKeys: [.contentTypeKey, .nameKey, .fileSizeKey])
            documentList.append(DocumentFile(
                title: resourcesValues.name!,
                size: resourcesValues.fileSize ?? 0,
                imageName: item,
                url: currentUrl,
                type: resourcesValues.contentType!.description
            ))
        }
        listImage[0] = documentList
        listImage[1] = listFileInBundle()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return listImage.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterdata[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Imported"
        }
        return "Bundle"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)
        let document = filterdata[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = document.title
        cell.detailTextLabel?.text = document.size.formattedSize()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let file = listImage[indexPath.section][indexPath.row]
        self.instantiateQLPreviewController(withUrl: file.url)
    }
    
    func instantiateQLPreviewController(withUrl url: URL) {
        let previewController = QLPreviewController()
        previewController.dataSource = self
        
        if let index = listImage[0].firstIndex(where: { $0.url == url }) {
            previewController.currentPreviewItemIndex = index
        } else if let index = listImage[1].firstIndex(where: { $0.url == url }) {
            previewController.currentPreviewItemIndex = index
        } else {
            print("Image with URL \(url) not found.")
        }
        
        present(previewController, animated: true)
    }
    
    func listFileInBundle() -> [DocumentFile] {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        var documentListBundle = [DocumentFile]()
        
        for item in items {
            if !item.hasSuffix("DS_Store") && item.hasSuffix(".jpg") {
                let currentUrl = URL(fileURLWithPath: path + "/" + item)
                let resourcesValues = try! currentUrl.resourceValues(forKeys: [.contentTypeKey, .nameKey, .fileSizeKey])
                
                documentListBundle.append(DocumentFile(
                    title: resourcesValues.name!,
                    size: resourcesValues.fileSize ?? 0,
                    imageName: item,
                    url: currentUrl,
                    type: resourcesValues.contentType!.description
                ))
            }
        }
        return documentListBundle
    }
}

extension Int {
    func formattedSize() -> String {
        let formatter = ByteCountFormatter()
        formatter.countStyle = .file
        formatter.allowedUnits = .useAll
        formatter.includesUnit = true
        formatter.isAdaptive = true
        return formatter.string(from: Measurement(value: Double(self), unit: .bytes))
    }
}

extension DocumentTableViewController: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return listImage.flatMap { $0 }.count
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        var currentIndex = index
        for subArray in listImage {
            if currentIndex < subArray.count {
                let documentFile = subArray[currentIndex]
                return documentFile.url as QLPreviewItem
            } else {
                currentIndex -= subArray.count
            }
        }
        return URL(string: "https://example.com") as! any QLPreviewItem
    }
}

extension DocumentTableViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        for url in urls {
            self.copyFileToDocumentsDirectory(fromUrl: url)
        }
        self.loadAllDocumentFile()
        tableView.reloadData()
    }
    
    func copyFileToDocumentsDirectory(fromUrl url: URL) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationUrl = documentsDirectory.appendingPathComponent(url.lastPathComponent)
        
        do {
            try FileManager.default.copyItem(at: url, to: destinationUrl)
        } catch {
            print(error)
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) { }
}

extension DocumentTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterdata = [[DocumentFile](), [DocumentFile]()]
        if searchText.isEmpty {
            filterdata = listImage
        } else {
            for (index, section) in listImage.enumerated() {
                for document in section {
                    if document.title.uppercased().contains(searchText.uppercased()) {
                        filterdata[index].append(document)
                    }
                }
            }
        }
        tableView.reloadData()
    }
}
