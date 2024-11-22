//
//  DocumentTableViewController.swift
//  Document App
//
//  Created by Émilien on 11/18/2024.
//

import UIKit
import QuickLook



class DocumentTableViewController: UITableViewController {
    
    var listImage: [[DocumentFile]] = [[DocumentFile](),[DocumentFile]()]
    let previewController = QLPreviewController()
    
    struct DocumentFile {
        var title: String
        var size: Int
        var imageName: String? = nil
        var url: URL
        var type: String
        
        static var generateData = [
            DocumentFile(title: "img4.jpg", size: 4186341, imageName: nil, url: URL(string: "file:///Users/emilien/Library/Developer/CoreSimulator/Devices/F15BD946-2C94-4341-9695-60AA421DFCB2/data/Containers/Bundle/Application/A828D002-12BC-4D3E-A047-5709EFF09A53/Document%20App.app/img4.jpg")!, type: "public.jpeg"),
            DocumentFile(title: "img3.jpg", size: 1670268, imageName: nil, url: URL(string: "file:///Users/emilien/Library/Developer/CoreSimulator/Devices/F15BD946-2C94-4341-9695-60AA421DFCB2/data/Containers/Bundle/Application/A828D002-12BC-4D3E-A047-5709EFF09A53/Document%20App.app/img3.jpg")!, type: "public.jpeg"),
            DocumentFile(title: "img2.jpg", size: 1985695, imageName: nil, url: URL(string: "file:///Users/emilien/Library/Developer/CoreSimulator/Devices/F15BD946-2C94-4341-9695-60AA421DFCB2/data/Containers/Bundle/Application/A828D002-12BC-4D3E-A047-5709EFF09A53/Document%20App.app/img2.jpg")!, type: "public.jpeg"),
            DocumentFile(title: "img1.jpg", size: 7039737, imageName: nil, url: URL(string: "file:///Users/emilien/Library/Developer/CoreSimulator/Devices/F15BD946-2C94-4341-9695-60AA421DFCB2/data/Containers/Bundle/Application/A828D002-12BC-4D3E-A047-5709EFF09A53/Document%20App.app/img1.jpg")!, type: "public.jpeg"),
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:  #selector(addDocument))
        self.loadAllDocumentFile()
    }
    
    @objc func addDocument() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.jpeg, .png])
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .overFullScreen
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true)
    }
    
    func loadAllDocumentFile(){
        
        
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
        // #warning Incomplete implementation, return the number of rows
        return listImage[section].count
    }
    
    override func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String?{
        if section == 0 {
            return "Imported"
        }
        
        return "Bundle"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)
        let document = listImage[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = document.title
        cell.detailTextLabel?.text = document.size.formattedSize()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let file = listImage[indexPath.section][indexPath.row]
        self.instantiateQLPreviewController(withUrl: file.url)
    }
    
    func instantiateQLPreviewController(withUrl url: URL){
        let previewController = QLPreviewController()
        previewController.dataSource = self
        if let index = listImage[0].firstIndex(where: { $0.url == url }) {
            previewController.currentPreviewItemIndex = index
        } else {
            if let index = listImage[1].firstIndex(where: { $0.url == url }) {
                previewController.currentPreviewItemIndex = index
            } else {
                
                print("Image with URL \(url) not found.")
            }
        }
        present(previewController, animated: true)
    }
        
    func listFileInBundle() -> [DocumentFile] {
        let fm = FileManager.default // Crée une instance de FileManager pour manipuler les fichiers
        let path = Bundle.main.resourcePath! // Récupère le chemin du dossier des ressources de l'app (les fichiers dans le bundle)
        let items = try! fm.contentsOfDirectory(atPath: path) // Récupère tous les fichiers dans le dossier des ressources
        
        var documentListBundle = [DocumentFile]() // Crée une liste vide pour stocker les fichiers sous forme de DocumentFile
        
        for item in items { // Parcourt chaque fichier dans le dossier
            if !item.hasSuffix("DS_Store") && item.hasSuffix(".jpg") { // Vérifie si le fichier n'est pas un fichier système et s'il est en .jpg
                let currentUrl = URL(fileURLWithPath: path + "/" + item) // Crée une URL pour accéder au fichier
                let resourcesValues = try! currentUrl.resourceValues(forKeys: [.contentTypeKey, .nameKey, .fileSizeKey]) // Récupère des informations sur le fichier (nom, taille, type)
                
                documentListBundle.append(DocumentFile( // Ajoute un nouvel objet DocumentFile à la liste avec les infos récupérées
                    title: resourcesValues.name!, // Le nom du fichier
                    size: resourcesValues.fileSize ?? 0, // La taille du fichier, ou 0 si non définie
                    imageName: item, // Le nom de l'image (fichier)
                    url: currentUrl, // L'URL du fichier
                    type: resourcesValues.contentType!.description) // Le type de contenu du fichier
                )
            }
        }
        return documentListBundle // Retourne la liste des fichiers sous forme de DocumentFile
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
        return URL(string: "https://example.com") as! any QLPreviewItem as QLPreviewItem
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
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
    }
}
