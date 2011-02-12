/*
 * RSwitch.fx
 *
 * Created on 1.4.2010, 12:32:24
 */
package net.ra100.cyd.UI;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.input.MouseEvent;

/**
 * @author ra100
 */
public class RSwitch extends CustomNode {

    public var primary: RButton;
    public var secondary: RButton;
    var isPrimary: Boolean = true;

    public override function create(): Node {
        return Group {
                    content: [
                        primary,
                        secondary,
                    ]
                    onMouseClicked: function (e: MouseEvent): Void {
                        change();
                    }
                };
    }

    public function change() {
        if (isPrimary) {
            primary.visible = false;
            secondary.visible = true;
            isPrimary = false;
        } else {
            primary.visible = true;
            secondary.visible = false;
            isPrimary = true;
        }
    }

}

