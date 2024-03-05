//
//  CustomSpinner.swift
//  NewsApp

import MBProgressHUD

actor CustomSpinner {
    @MainActor
    func showIndicator(spinnerView: UIView?, withTitle title: String?) {
        guard let LoadingSpinnerView = spinnerView else { return }        
        let progressHUD = MBProgressHUD.showAdded(to: LoadingSpinnerView, animated: true)
        progressHUD.label.text = title ?? ""
        progressHUD.isUserInteractionEnabled = false
        progressHUD.show(animated: true)
    }
    
    @MainActor
    func hideIndicator(spinnerView:UIView?) {
        guard let LoadingSpinnerView = spinnerView else { return }
        MBProgressHUD.hide(for: LoadingSpinnerView, animated: true)
    }
}
