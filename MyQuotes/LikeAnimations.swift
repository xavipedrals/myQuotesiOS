//
//  LikeAnimations.swift
//  MyQuotes
//
//  Created by Xavi on 19/09/16.
//  Copyright © 2016 xavi. All rights reserved.
//

import UIKit

class LikeAnimations {
    
    static var bigTransform = CGAffineTransform(scaleX: 1.4, y: 1.4)
    static var normalTransform = CGAffineTransform(scaleX: 1, y: 1)
    static var smallTransform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    static var fadeOut = CGAffineTransform(scaleX: 0.5, y: 0.5)
    
    static func doWhiteLikeAnimation(likeView: UIImageView) {
        likeView.isHidden = false
        bigSizeIncrease(likeView: likeView)
    }
    
    static func bigSizeIncrease(likeView: UIImageView) {
        UIView.animate(withDuration: 0.3, animations: {
            likeView.alpha = 1
            likeView.transform = bigTransform
            }, completion: {
                value in
                turnNormalSize(likeView: likeView, fadeOutNext: false)
        })
    }
    
    static func turnNormalSize(likeView: UIImageView, fadeOutNext: Bool) {
        UIView.animate(withDuration: 0.15, animations: {
            likeView.transform = normalTransform
            }, completion: {
                value in
                if fadeOutNext {
                    fadeOut(likeView: likeView)
                }
                else {
                    smallSizeIncrease(likeView: likeView)
                }
        })
    }
    
    static func smallSizeIncrease(likeView: UIImageView) {
        UIView.animate(withDuration: 0.15, animations: {
            likeView.transform = smallTransform
            }, completion: {
                value in
                turnNormalSize(likeView: likeView, fadeOutNext: true)
        })
    }
    
    static func fadeOut(likeView: UIImageView) {
        UIView.animate(withDuration: 0.15, delay: 0.15, animations: {
            likeView.transform = fadeOut
            likeView.alpha = 0
            }, completion: {
                value in
                likeView.transform = CGAffineTransform(scaleX: 1, y: 1)
                likeView.isHidden = true
        })
    }
    
    //optimizable
    static func doRedLikeAnimation(likeView: UIImageView) {
        redBigSizeIncrease(likeView: likeView)
    }
    
    static func redBigSizeIncrease(likeView: UIImageView) {
        UIView.animate(withDuration: 0.3, animations: {
            likeView.alpha = 1
            likeView.transform = bigTransform
            }, completion: {
                value in
                redTurnNormalSize(likeView: likeView, lastAnimation: false)
        })
    }
    
    static func redTurnNormalSize(likeView: UIImageView, lastAnimation: Bool) {
        UIView.animate(withDuration: 0.15, animations: {
            likeView.transform = normalTransform
            }, completion: {
                value in
                if !lastAnimation {
                    redSmallSizeIncrease(likeView: likeView)
                }
        })
    }
    
    static func redSmallSizeIncrease(likeView: UIImageView) {
        UIView.animate(withDuration: 0.15, animations: {
            likeView.transform = smallTransform
            }, completion: {
                value in
                redTurnNormalSize(likeView: likeView, lastAnimation: true)
        })
    }
}
