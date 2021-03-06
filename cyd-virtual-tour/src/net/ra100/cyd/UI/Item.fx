/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package net.ra100.cyd.UI;

import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.scene.Group;
import javafx.scene.image.ImageView;
import net.ra100.cyd.main.PanoScene;

/**
 * @author ra100
 */

public class Item extends CustomNode {

    public var itemid: Integer;
    public var type: ItemType;
    public var myScene: PanoScene;
    
    // 0 - got it, 1 - found and dropped
    public var status: Integer = -1;
    
    public var button: RButton = RButton {
            image: ImageView {image: type.image}
            action: function (): Void {
                action();
            }
        }

    public override function create(): Node {
        return Group { content: [button]};
    }

    public function drop(): Void {
        status = 1;
        button.opacity = 0.5;
        button.disable = true;
    }

    public function take(id: Integer): Void {
        itemid = id;
        status = 0;
        button.opacity = 1;
        button.disable = false;
    }

    public function action(): Void {
        if (status == 0) {
            myScene.bagPanel.dropItem(this);
        } else {
            myScene.bagPanel.takeItem(this);
        }
    }

    public function getName(): String {
        if (myScene.language == myScene.SK) {
            return type.name[0];
        }
        if (myScene.language == myScene.EN) {
            return type.name[1];
        }
        return null;
    }

    public function getText(): String {
        if (myScene.language == myScene.SK) {
            return type.text[0];
        }
        if (myScene.language == myScene.EN) {
            return type.text[1];
        }
        return null;
    }

    

}
