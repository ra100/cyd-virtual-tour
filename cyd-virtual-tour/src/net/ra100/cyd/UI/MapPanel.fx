/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package net.ra100.cyd.UI;

import javafx.scene.CustomNode;
import net.ra100.cyd.main.PanoScene;
import javafx.scene.control.Label;
import net.ra100.cyd.UI.res.MapBG;
import javafx.scene.Node;
import javafx.geometry.VPos;
import javafx.scene.layout.Stack;
import javafx.animation.transition.TranslateTransition;

/**
 * @author ra100
 * panel pre zobrazenie mapy
 */

public class MapPanel extends CustomNode {
    public var hideWidth: Integer = 164;
    public var myScene: PanoScene;
    var active: Boolean = true;
    var label = Label {text: " "
    style: "font-family: 'Helvetica'; font-size: 12pt"};
    def bg = MapBG{};

    public override function create(): Node {
        hide();
        return Stack {
                nodeVPos: VPos.TOP,
            content: [
        bg,
        ]
        }
    }

    public function show() {
        active = true;
        TranslateTransition {
            duration: 0.5s
            node: this
            fromX: 0 - hideWidth
            toX: 0
            repeatCount: 1
        }.play();
    }

    public function hide() {
        active = false;
        TranslateTransition {
            duration: 0.5s
            node: this
            fromX: 0
            toX: 0 - hideWidth
            repeatCount: 1
        }.play();
    }

    public function changeState() {
        if (active) {
            hide();
        } else {
            show();
        }
    }
}
