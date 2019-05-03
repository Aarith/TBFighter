//
//  GameScene.swift
//  TBFighter
//
//  Created by Ian Campbell Brothers on 4/17/19.
//  Copyright © 2019 Ian Campbell Brothers. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    let player = SKSpriteNode(color: SKColor.blue, size: CGSize(width: 150, height: 400))
    let enemy = SKSpriteNode(color: SKColor.red, size: CGSize(width: 150, height: 400))
    let menuback = SKSpriteNode(color: SKColor.gray, size: CGSize(width: 800, height: 600))
    let attackbutton = SKSpriteNode(color: SKColor.red, size: CGSize(width: 220, height: 120))
    let attackbuttontext = SKLabelNode(fontNamed: "Arial")
    let guardbutton = SKSpriteNode(color: SKColor.blue, size: CGSize(width: 220, height: 120))
    let guardbuttontext = SKLabelNode(fontNamed: "Arial")
    let healthLabel = SKLabelNode(fontNamed: "Courier")
    var playerHP = Int()
    let enemylabel = SKLabelNode(fontNamed: "Courier")
    var enemyHP = Int()
    var enemyActions = [String]()


    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
       
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        player.position = CGPoint(x: frame.size.width * 0.2, y: frame.size.height * 0.08)
        player.zPosition = 10
        addChild(player)
        enemy.position = CGPoint(x: frame.size.width * -0.2, y: frame.size.height * 0.08)
        enemy.zPosition = 10
        addChild(enemy)
        menuback.position = CGPoint(x: frame.size.width * 0, y: frame.size.height * -0.35)
        menuback.zPosition = 0
        addChild(menuback)
        attackbutton.position = CGPoint(x: frame.size.width * 0, y: frame.size.height * -0.20)
        attackbuttontext.position = CGPoint(x: frame.size.width * 0, y: frame.size.height * -0.21)
        attackbutton.zPosition = 1
        attackbuttontext.zPosition = 2
        attackbuttontext.text = "Attack"
        attackbuttontext.fontSize = 72
        attackbuttontext.fontColor = SKColor.black
        attackbutton.isUserInteractionEnabled = true
        addChild(attackbutton)
        addChild(attackbuttontext)
        guardbutton.position = CGPoint(x: frame.size.width * 0, y: frame.size.height * -0.35)
        guardbuttontext.position = CGPoint(x: frame.size.width * 0, y: frame.size.height * -0.36)
        guardbutton.zPosition = 1
        guardbuttontext.zPosition = 2
        guardbuttontext.text = "Guard"
        guardbuttontext.fontSize = 72
        guardbuttontext.fontColor = SKColor.black
        guardbutton.isUserInteractionEnabled = true
        addChild(guardbutton)
        addChild(guardbuttontext)
        setupHud()
        
        enemyActions = ["Attack", "Guard"]
        
        
    }
    
    func setupHud() {
        healthLabel.name = "healthHud"
        healthLabel.fontSize = 25
        playerHP = 100
        
        healthLabel.fontColor = SKColor.red
        healthLabel.text = String(format: "Your HP: \(playerHP)")
        
        healthLabel.position = CGPoint(x: frame.size.width * 0.21, y: frame.size.height * 0.35)
        healthLabel.zPosition = 10
        addChild(healthLabel)
        
        enemylabel.name = "enemyHP"
        enemylabel.fontSize = 25
        enemyHP = 100
        
        enemylabel.fontColor = SKColor.red
        enemylabel.text = String(format: "Enemy HP: \(enemyHP)")
        
        enemylabel.position = CGPoint(x: frame.size.width * -0.21, y: frame.size.height * 0.35)
        enemylabel.zPosition = 10
        addChild(enemylabel)
    }
    
    
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        if attackbutton.contains(touchLocation) {
            var enemychoice = enemyActions.randomElement()
            var damage = Int.random(in: 5 ..< 20)
            if enemychoice == "Guard"{
                print("Enemy guarded!")
                damage /= 2
            }
            print("Attack, did \(damage) damage!")
            enemyHP -= damage
            enemylabel.text = "Enemy HP: \(enemyHP)"
            sleep(1)
            
            if enemychoice == "Attack" {
                var enemydamage = Int.random(in: 3 ..< 17)
                playerHP -= enemydamage
                print("You took \(enemydamage) damage!")
                healthLabel.text = "Your HP: \(playerHP)"
            }
        }
        if guardbutton.contains(touchLocation) {
            print("Guard")
        }
        
    }
    
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
