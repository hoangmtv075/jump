//
//  MainMenu.swift
//  Jump
//
//  Created by Thanh Hoang on 19/10/2021.
//

import SpriteKit

class MainMenu: SKScene {
    
    //MARK: - Properties
    private var bgNode: SKSpriteNode!
    private var jumNode: SKSpriteNode!
    private var easeNode: SKSpriteNode!
    private var mediumNode: SKSpriteNode!
    private var hardNode: SKSpriteNode!
    
    private var mediumLockNode: SKSpriteNode!
    private var hardLockNode: SKSpriteNode!
    
    private var isEase = false {
        didSet {
            updateBtn(node: easeNode, event: isEase)
        }
    }
    
    private var isMedium = false {
        didSet {
            updateBtn(node: mediumNode, event: isMedium)
        }
    }
    
    private var isHard = false {
        didSet {
            updateBtn(node: hardNode, event: isHard)
        }
    }
    
    //MARK: - Lifecycle
    override func didMove(to view: SKView) {
        setupNodes()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        let node = atPoint(touch.location(in: self))
        
        if node.name == "Ease" && !isEase {
            isEase = true
        }
        
        if node.name == "Medium" && !isMedium {
            isMedium = true
        }
        
        if node.name == "Hard" && !isHard {
            isHard = true
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if isEase {
            isEase = false
            
            let scene = EaseScene(size: CGSize(width: screenWidth, height: screenHeight))
            scene.scaleMode = .aspectFill
            view?.presentScene(scene, transition: .doorway(withDuration: 1.5))
        }
        
        if isMedium {
            isMedium = false
            
            let scene = MediumScene(size: CGSize(width: screenWidth, height: screenHeight))
            scene.scaleMode = .aspectFill
            view?.presentScene(scene, transition: .doorway(withDuration: 1.5))
        }
        
        if isHard {
            isHard = false
            
            let scene = HardScene(size: CGSize(width: screenWidth, height: screenHeight))
            scene.scaleMode = .aspectFill
            view?.presentScene(scene, transition: .doorway(withDuration: 1.5))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let touch = touches.first else { return }
        let node = atPoint(touch.location(in: self))
        
        if let parent = easeNode?.parent, node.name == "Ease" {
            isEase = easeNode.contains(touch.location(in: parent))
        }
        
        if let parent = mediumNode?.parent, node.name == "Medium" {
            isMedium = mediumNode.contains(touch.location(in: parent))
        }
        
        if let parent = hardNode?.parent, node.name == "Hard" {
            isHard = hardNode.contains(touch.location(in: parent))
        }
    }
}

extension MainMenu {
    
    private func setupNodes() {
        //TODO: - BackgroundNode
        bgNode = SKSpriteNode(imageNamed: "background")
        bgNode.zPosition = -1.0
        bgNode.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(bgNode)
        
        //TODO: - JumpNode
        let scale: CGFloat = appDL.isIPhoneX ? 0.6 : 0.7
        jumNode = SKSpriteNode(imageNamed: "icon-jump")
        jumNode.setScale(scale)
        jumNode.position = CGPoint(x: frame.midX, y: frame.midY + jumNode.frame.height*1.5)
        jumNode.zPosition = 1.0
        addChild(jumNode)
        
        //TODO: - EaseNode
        easeNode = SKSpriteNode(imageNamed: "icon-ease")
        easeNode.setScale(scale)
        easeNode.position = CGPoint(x: frame.midX, y: frame.midY)
        easeNode.zPosition = 10.0
        easeNode.name = "Ease"
        addChild(easeNode)
        
        //TODO: - MediumNode
        mediumNode = SKSpriteNode(imageNamed: "icon-medium")
        mediumNode.setScale(scale)
        mediumNode.position = CGPoint(x: frame.midX,
                                      y: easeNode.position.y - easeNode.frame.height - 40)
        mediumNode.zPosition = 10.0
        addChild(mediumNode)
        
        //TODO: - HardNode
        hardNode = SKSpriteNode(imageNamed: "icon-hard")
        hardNode.setScale(scale)
        hardNode.position = CGPoint(x: frame.midX,
                                    y: mediumNode.position.y - mediumNode.frame.height - 40)
        hardNode.zPosition = 10.0
        addChild(hardNode)
        
        //TODO: - MediumLockNode
        mediumLockNode = SKSpriteNode(imageNamed: "icon-lock")
        mediumLockNode.setScale(0.3)
        mediumLockNode.position = CGPoint(x: mediumNode.frame.maxX - mediumLockNode.frame.width/2 - 10,
                                          y: mediumNode.frame.midY + 5)
        mediumLockNode.zPosition = 15.0
        addChild(mediumLockNode)
        
        //TODO: - HardLockNode
        hardLockNode = SKSpriteNode(imageNamed: "icon-lock")
        hardLockNode.setScale(0.3)
        hardLockNode.position = CGPoint(x: hardNode.frame.maxX - hardLockNode.frame.width/2 - 10,
                                        y: hardNode.frame.midY + 5)
        hardLockNode.zPosition = 15.0
        addChild(hardLockNode)
        
        let isMediumLock = UserDefaults.standard.bool(forKey: "UnlockMediumKey")
        let isHardLock = UserDefaults.standard.bool(forKey: "UnlockHardKey")
        
        mediumNode.alpha = isMediumLock ? 1.0 : 0.3
        hardNode.alpha = isHardLock ? 1.0 : 0.3
        
        mediumLockNode.isHidden = isMediumLock
        hardLockNode.isHidden = isHardLock
        
        mediumNode.name = isMediumLock ? "Medium" : nil
        hardNode.name = isHardLock ? "Hard" : nil
    }
    
    func updateBtn(node: SKNode, event: Bool) {
        var alpha: CGFloat = 1.0
        if event {
            alpha = 0.5
        }
        
        node.run(.fadeAlpha(to: alpha, duration: 0.1))
    }
}
