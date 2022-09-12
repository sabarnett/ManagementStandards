
// Thanks to http://www.labs.saachitech.com/2012/10/23/pdf-generation-using-uiprintpagerenderer
// Note: including images in the HTML won't work, see here:
// https://github.com/nyg/HTMLWithImagesToPDF

import UIKit

struct HTMLtoPDF {

    static func toPDF(_ html: String) -> NSMutableData {
        
        // 1. Create a print formatter
        let fmt = UIMarkupTextPrintFormatter(markupText: html)

        // 2. Assign print formatter to UIPrintPageRenderer

        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAt: 0)

        // 3. Assign paperRect and printableRect

        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        let printPage = CGRect(x: 0, y: 0, width: 535.2, height: 781.8) // A4, 72 dpi
        render.setValue(page, forKey: "paperRect")
        render.setValue(printPage, forKey: "printableRect")

        // 4. Create PDF context and draw

        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)

        for i in 0..<render.numberOfPages {
            UIGraphicsBeginPDFPage();
            render.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }

        UIGraphicsEndPDFContext();
        
        // 5. Return PDF file
        return pdfData
    }
}
