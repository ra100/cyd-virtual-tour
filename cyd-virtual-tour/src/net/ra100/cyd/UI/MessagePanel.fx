/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package net.ra100.cyd.UI;

import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.scene.layout.Stack;
import javafx.geometry.VPos;
import net.ra100.cyd.UI.res.MessageBG;
import javafx.scene.layout.VBox;
import javafx.scene.text.Text;
import javafx.scene.layout.HBox;
import javafx.geometry.Insets;
import javafx.geometry.HPos;
import javafx.scene.effect.Glow;
import net.ra100.cyd.UI.res.RefreshButton;
import net.ra100.cyd.UI.res.ExitButton;
import net.ra100.cyd.main.PanoScene;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.ext.swing.SwingTextField;
import javafx.scene.control.TextBox;
import javafx.scene.layout.LayoutInfo;

/**
 * @author ra100
 */

public class MessagePanel extends CustomNode {

    public var myScene: PanoScene;
    public var label = Text {
        content: "Error message"
        visible: true
        translateX: 5
        translateY: 5
        fill: Color.WHITE
        id: "message"
        wrappingWidth: 300
    };

    public var refresh: RButton = RButton {
        image: RefreshButton { };
        visible: true
        overEffect: Glow {
            level: 1
        }
        action: function(): Void {

        }
    }

    var close: RButton = RButton {
        image: ExitButton { };
        visible: true
        overEffect: Glow {
            level: 1
        }
        action: function (): Void {
            this.textfield.visible = false;
            this.visible = false;
        }
    }

    public var textfield = TextBox {
        layoutY: 30
        translateY: 20
	text: "anonym"
	columns: 12
	selectOnFocus: true
        visible: false
        editable: true
    }

    var background = Rectangle {
	x: 0
        y: 0
	width: 80
        height: 40
        opacity: 0.0
    }

    var background2 = Rectangle {
	x: 0
        y: 0
	width: bind myScene.screenWidth
        height: bind myScene.screenHeight
	fill: Color.BLACK
        opacity: 0.5
    }

    def bg = MessageBG{};

    public override function create(): Node {
        return 
        Stack {
            blocksMouse: true
            content: [
            background2,
            Stack {

            content: [
                bg,
                background,
                VBox {
                    nodeVPos: VPos.TOP
                    padding: Insets { top: 4 right: 4 bottom: 4 left: 4}
                    content: [label, textfield]
                }
                HBox {
                    spacing: 10
                    nodeVPos: VPos.BOTTOM;
                    nodeHPos: HPos.CENTER
                    hpos: HPos.CENTER
                    padding: Insets { top: 4 right: 4 bottom: 4 left: 4}
                    content: [refresh, close]
                }
            ]
            layoutInfo: LayoutInfo {
                maxHeight: bg.boundsInLocal.height
                maxWidth: bg.boundsInLocal.width }
        }
        ]
        }
    }
}
