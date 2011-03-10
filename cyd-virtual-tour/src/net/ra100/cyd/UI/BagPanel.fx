/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package net.ra100.cyd.UI;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.layout.Stack;
import javafx.scene.layout.Panel;
import net.ra100.cyd.UI.res.ExitButton;
import javafx.scene.effect.Glow;
import net.ra100.cyd.main.PanoScene;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import net.ra100.cyd.utils.DataElement;
import javafx.scene.control.Label;
import javafx.scene.layout.LayoutInfo;
import javafx.geometry.VPos;
import javafx.geometry.HPos;

/**
 * @author Rastislav R@100 Švarba
 */

public class BagPanel extends CustomNode {

    public var myScene : PanoScene;

    public var bag: Bag;

    var background = Rectangle {
        arcWidth: 5
        arcHeight: 5
	width: 400
        height: 180
	fill: Color.web("#000000")
        opacity: 0.7
    }

    var background0 = Rectangle {
        arcWidth: 8
        arcHeight: 8
	width: 406
        height: 186
	fill: Color.web("#ffffff")
        opacity: 0.7
    }

    var close: RButton = RButton {
        translateX: 200
        translateY: -90
        image: ExitButton { };
        visible: true
        overEffect: Glow {
            level: 1
        }
        action: function (): Void {
            this.visible = false;
        }
    }

    var info = Label {
        textFill: Color.LIGHTGRAY
        translateX: 15
        translateY: 8
         layoutInfo: LayoutInfo {
            vpos: VPos.TOP
            hpos: HPos.LEFT
         }
    }

    public override function create(): Node {
        return Stack {
            layoutX: 200
            layoutY: 150
            content: [
                background0,
                background,
                close,
                info,
                bag
            ]
        }
    }

    public function takeItem(it: Item): Boolean {
        for (ii in bag.items) {
            if ((it.type == ii.type) and (ii.status == 0)) {
                myScene.messagePanel.label.content = ##"Already have";
                myScene.messagePanel.refresh.visible = false;
                myScene.messagePanel.visible = true;
                return true;
            }
        }

        myScene.dataloader.action = 'takeitem';
        myScene.dataloader.input = [DataElement {value: String.valueOf(it.itemid) , key: "iid"},
                DataElement {value: myScene.extensionDisplay.ename(), key: "ename"}];
        myScene.dataloader.load(0);
        var status = myScene.dataloader.getValueByKey("status");

        if (status == "other") {
            myScene.messagePanel.label.content = ##"Already have";
            myScene.messagePanel.refresh.visible = false;
            myScene.messagePanel.visible = true;
            return true;
        }

        if (status == "ok" or status == "found") {
            delete it from myScene.extensionDisplay.items;
            bag.addItem(it);
            return true;
        }

        if (status == "all") {
            delete it from myScene.extensionDisplay.items;
            bag.addItem(it);
            myScene.messagePanel.label.content = ##"All";
            myScene.messagePanel.textfield.visible = true;
            myScene.messagePanel.refresh.visible = true;
            myScene.messagePanel.refresh.action = function(): Void {
                
                myScene.dataloader.action = 'score';
                myScene.dataloader.input = [DataElement {value: myScene.messagePanel.textfield.rawText , key: "name"}];
                myScene.dataloader.load(0);

                myScene.messagePanel.textfield.visible = false;
                myScene.messagePanel.visible = false;
                }
            myScene.messagePanel.visible = true;
            return true;
        }

        if (status == "not found") {
            myScene.extensionDisplay.reloadItems();

            myScene.messagePanel.label.content = ##"Not Found";
            myScene.messagePanel.refresh.action = function(): Void {
                myScene.messagePanel.visible = false;
                }
            myScene.messagePanel.visible = true;
            return true;
        }

        return true;
    }

    public function dropItem(it: Item): Boolean {
        myScene.dataloader.action = 'dropitem';
        myScene.dataloader.input = [DataElement {value: String.valueOf(it.itemid) , key: "iid"},
                DataElement {value: myScene.extensionDisplay.ename(), key: "ename"}];
        myScene.dataloader.load(0);

        it.drop();
        // vytvori sa kopia, nove tlacidlo v extension
        myScene.extensionDisplay.loadItem(it.itemid, it.type.id);
        myScene.extensionDisplay.reloadItems();
        myScene.extensionDisplay.showitems();
        return true;
    }

    public function updateLang(): Void {
        info.text = ##"Bag info";
    }

}
