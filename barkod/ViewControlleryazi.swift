//
//  ViewControlleryazi.swift
//  barkod
//
//  Created by halil ibrahim Elkan on 27.12.2021.
//

import UIKit

class ViewControlleryazi: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Görünümü tipik olarak bir uçtan yükledikten sonra herhangi bir ek kurulum
    }

    @IBAction func printText(_ sender: Any) {
        // UIPrintInteractionController, kullanıcı arabirimini sunar ve yazdırmayı yönetilir
        let yazdırsayfa = UIPrintInteractionController.shared
        // UIPrintinfo nesnesi, yazdırma işi hakkında bilgiler içerir, Bu bilgi, UIPrintInteractionController'ın printInfo özelliğine atanır.
        let yazdırinfo = UIPrintInfo(dictionary:nil)
        yazdırinfo.outputType = UIPrintInfo.OutputType.general
        yazdırinfo.jobName = "print Job"
        yazdırsayfa.printInfo = yazdırinfo
        
        // Yazdırılan metin biçimlendir. burada yazdırma sayfası için ekler tanımla
        let formatter = UIMarkupTextPrintFormatter(markupText: textView.text)
        formatter.perPageContentInsets = UIEdgeInsets(top: 72, left: 72, bottom: 72, right: 72)
        yazdırsayfa.printFormatter = formatter
        
        //  bir yazıcı ve kopya sayısını seçmesi için iPhone yazdırma arayüzü .
        yazdırsayfa.present(animated: true, completionHandler: nil)
    }
    
}

