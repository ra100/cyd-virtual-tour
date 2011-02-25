/*
 * RightPanel.fx
 *
 * Created on 1.4.2010, 19:05:08
 */
package net.ra100.cyd.UI;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.animation.transition.TranslateTransition;
import javafx.scene.effect.Glow;
import javafx.scene.input.MouseEvent;
import net.ra100.cyd.UI.res.*;
import java.lang.System;
import javafx.io.http.HttpRequest;
import net.ra100.cyd.main.PanoScene;
import java.io.IOException;
import java.lang.Integer;

/**
 * @author ra100
 */
public class RightPanel extends CustomNode {

    public var hideWidth: Integer = 27;
    public var hideHeight: Integer = 27;
    public var myScene: PanoScene;
    var active: Boolean = true;
    def exitButton = RButton {
                translateX : 8,
                translateY : 2,
                image: ExitButton { }
                overEffect: Glow {
                    level: 1
                }
                action: function (): Void {
                    FX.exit();
                }
            };
            
    def exitMenuBG = ExitMenuBG { };

    var startTime : Long;

    var request: HttpRequest = HttpRequest {
        method: HttpRequest.GET

        onInput: function(input: java.io.InputStream) {
            try {
                input.close();
            } catch(ex : IOException) {
                ex.printStackTrace();
            }
        }
    }

    public override function create(): Node {
        startTime = System.currentTimeMillis();
        hide();
        return Group {
            content: [
                exitMenuBG,
                exitButton
            ]
            onMouseEntered: function (e: MouseEvent): Void {
                show();
            }
            onMouseExited: function (e: MouseEvent): Void {
                hide();
            }
        }
    }

    public function show() {
        if (active == false) {
            TranslateTransition {
                duration: 0.2s
                node: this
                fromY: 0 - hideHeight
                toY: -1
                fromX: hideWidth
                toX: 1
                repeatCount: 1
            }.play();
            active = true;
        }
    }

    public function hide() {
        if (active) {
            TranslateTransition {
                duration: 0.3s
                node: this
                fromY: -1
                toY: 0 - hideHeight
                fromX: 1
                toX: hideWidth
                repeatCount: 1
            }.play();
            active = false;
        }
    }

    function writeVisit(){
//        var duration  = (System.currentTimeMillis()-startTime)/1000;
//        var trace = myScene.getTrace();
//        request.location = "http://ra100.scifi-guide.net/brhlovce/scripts/visit.php?duration={duration}&trace={trace}";
//        try {
//            request.start();
//        } catch( ex: Exception) {
//            println("Chyba http poziadavky");
//        }

    }


}
