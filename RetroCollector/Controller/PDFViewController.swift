//
//  PDFViewController.swift
//  RetroCollector
//
//  Created by Manuel Carvalho on 28/8/20.
//  Copyright © 2020 Manuel Carvalho. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {

    var detailPart:Part? = nil
    public var documentData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pdfView = PDFView()

        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)

        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        if let data = documentData {
          pdfView.document = PDFDocument(data: data)
          pdfView.autoScales = true
        }
        
        //pdfView.document = document
        
        let pdfData = createPDF()
        
        pdfView.document = PDFDocument(data: pdfData)
        pdfView.autoScales = true
        
        let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
        let pdfNameFromUrl = "RetroCollector - myPdf.pdf"
        let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
        do {
            try pdfData.write(to: actualPath, options: .atomic)
            print("pdf successfully saved!")
        } catch {
            print("Pdf could not be saved")
        }
    }
    
    
    
    func createPDF() -> Data {
      // 1
      let pdfMetaData = [
        kCGPDFContextCreator: "Cart Builder",
        kCGPDFContextAuthor: "Manuel",
        kCGPDFContextOwnerPassword: "myPassword123",
        kCGPDFContextTitle: "Lorem Ipsum",
      ]
      let format = UIGraphicsPDFRendererFormat()
      format.documentInfo = pdfMetaData as [String: Any]

      // 2
      let pageWidth = 8.5 * 72.0
      let pageHeight = 11 * 72.0
      let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

      // 3
      let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
      // 4
      let data = renderer.pdfData { (context) in
        // 5
        context.beginPage()
        // 6
        let attribHead = [
          NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40)
        ]
        let attributes = [
          NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
        ]
        let cart = "Cartridge: \(detailPart?.catridge ?? "")\nComputer: \(detailPart?.computer ?? "") \n Part Number: \(detailPart?.partNum ?? "")"
        
        let headIng = "Cartridge Details"
        headIng.draw(at: CGPoint(x: 70, y: 0), withAttributes: attribHead)
        let text = "\(cart)"
        text.draw(at: CGPoint(x: 10, y: 100), withAttributes: attributes)
      }

      return data
    }
    

    @IBAction func btnSharePDF(_ sender: UIBarButtonItem) {
        print("Share PDF pressed")
        
        var pdfURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
               pdfURL = pdfURL.appendingPathComponent( "RetroCollector - myPdf.pdf") as URL
        
        //let data = try! Data(contentsOf: pdfURL)

        //let docu = PDFDocument(data: data)
        
        do {
            //let data = try Data(contentsOf: pdfURL)

            //try data.write(to: url as URL)

            let activitycontroller = UIActivityViewController(activityItems: [pdfURL], applicationActivities: nil)
            if activitycontroller.responds(to: #selector(getter: activitycontroller.completionWithItemsHandler))
            {
                activitycontroller.completionWithItemsHandler = {(type, isCompleted, items, error) in
                    if isCompleted
                    {
                        print("completed")
                    }
                }
            }

            activitycontroller.excludedActivityTypes = [UIActivity.ActivityType.airDrop]
            activitycontroller.popoverPresentationController?.sourceView = self.view
            self.present(activitycontroller, animated: true, completion: nil)

        }

    }
    
   
}
