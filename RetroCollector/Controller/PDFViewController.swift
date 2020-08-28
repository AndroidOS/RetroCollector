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
        
        pdfView.document = PDFDocument(data: createPDF())
        pdfView.autoScales = true

        //print("\(detailPart)")
    }
    
    func createPDF1() {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = (documentsDirectory as NSString).appendingPathComponent("foo.pdf") as String

        let pdfTitle = "Swift-Generated PDF"
        let pdfMetadata = [
            // The name of the application creating the PDF.
            kCGPDFContextCreator: "Your iOS App",

            // The name of the PDF's author.
            kCGPDFContextAuthor: "Foo Bar",

            // The title of the PDF.
            kCGPDFContextTitle: "Lorem Ipsum",

            // Encrypts the document with the value as the owner password. Used to enable/disable different permissions.
            kCGPDFContextOwnerPassword: "myPassword123"
        ]

        // Creates a new PDF file at the specified path.
        UIGraphicsBeginPDFContextToFile(filePath, CGRect.zero, pdfMetadata)

        // Creates a new page in the current PDF context.
        UIGraphicsBeginPDFPage()

        // Default size of the page is 612x72.
        let pageSize = UIGraphicsGetPDFContextBounds().size
        let font = UIFont.preferredFont(forTextStyle: .largeTitle)

        // Let's draw the title of the PDF on top of the page.
        let attributedPDFTitle = NSAttributedString(string: pdfTitle, attributes: [NSAttributedString.Key.font: font])
        let stringSize = attributedPDFTitle.size()
        let stringRect = CGRect(x: (pageSize.width / 2 - stringSize.width / 2), y: 20, width: stringSize.width, height: stringSize.height)
        attributedPDFTitle.draw(in: stringRect)

        // Closes the current PDF context and ends writing to the file.
        UIGraphicsEndPDFContext()
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
        let attributes = [
          NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
        ]
        let cart = "Cartridge: \(detailPart?.catridge ?? "")\nComputer: \(detailPart?.computer ?? "") \n Part Number: \(detailPart?.partNum ?? "")"
        
        let text = "\(cart)"
        text.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
      }

      return data
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
