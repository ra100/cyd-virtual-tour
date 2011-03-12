/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package net.ra100.cyd.UI;

import javafx.scene.CustomNode;
import net.ra100.cyd.main.PanoScene;
import net.ra100.cyd.UI.res.MapBG;
import javafx.scene.Node;
import javafx.scene.layout.Stack;
import javafx.animation.transition.TranslateTransition;
import javafx.scene.layout.VBox;
import javafx.scene.layout.HBox;
import net.ra100.cyd.scene.Shape;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.shape.Polyline;
import javafx.scene.Group;
import javafx.scene.transform.Rotate;
import net.ra100.cyd.UI.res.ViewDirection;
import net.ra100.cyd.UI.res.HidePathButton;
import javafx.scene.effect.Glow;
import net.ra100.cyd.UI.res.ShowPathButton;
import net.ra100.cyd.utils.AsyncTask;
import java.lang.Thread;
import java.lang.InterruptedException;
import net.ra100.cyd.utils.DataLoader;
import javafx.scene.layout.LayoutInfo;
import net.ra100.cyd.UI.res.NicePathButton;

/**
 * @author ra100
 * panel pre zobrazenie mapy
 */

public class MapPanel extends CustomNode {
    def height: Float = 150;
    def width: Float = 150;
    public var hideWidth: Float = 164;
    public var myScene: PanoScene;
    var active: Boolean = true;

    def bg = MapBG{};

    public var activeVisitos: String = ##"Active vistors";

    public var scale: Float = 1;
    public var xoffset: Float = 0;
    public var yoffset: Float = 0;

    public var activePano: MapPoint;
    public var mapPanos: MapPoint[];
    public var path: MapPoint[];

    var pathButton = RSwitch {
        primary : RButton {
            image: ShowPathButton { };
            text: ##"HidePath"
            label : myScene.topPanel.label
            overEffect: Glow {
                level: 1
            }
            action: function (): Void {
                pathlines.visible = false;
            }
        };
        secondary :  RButton {
            image: HidePathButton { };
            text: ##"ShowPath"
            label : myScene.topPanel.label
            overEffect: Glow {
                level: 1
            }
            action: function (): Void {
                pathlines.visible = true;
            }
            visible : false;
        }
    }

    /**
    * prepisnac zobrazenia nicepaths
    */
    var niceButton = RSwitch {
        primary : RButton {
            image: NicePathButton { };
            text: ##"HideNice"
            label : myScene.topPanel.label
            overEffect: Glow {
                level: 1
            }
            action: function (): Void {
                nicepathvisible = false;
            }
        };
        secondary :  RButton {
            image: NicePathButton { };
            text: ##"ShowNice"
            label : myScene.topPanel.label
            overEffect: Glow {
                level: 1
            }
            action: function (): Void {
                nicepathvisible = true;
            }
            visible : false;
        }
    }

    /*helper*/
    def back: Rectangle = Rectangle {
	x: 0, y: 0
	width: 150, height: 200
	fill: Color.web("#cccccc")
        opacity: 0.0
    }

    public var pathlines: Polyline = Polyline {
        points: []
        strokeWidth: 2.0
        stroke: Color.RED
        visible: true
        layoutX: 32
        layoutY: 32
    };

    public var rotation = Rotate {
        angle: 0
        pivotX: 0
        pivotY: 0
    };

    public var compass: Group = Group {
        layoutX: 32.5, layoutY: 32.5
        content: [ViewDirection{transforms: rotation}]
    }

    public var nicepathvisible: Boolean = true;

    public var map: CustomPanel = CustomPanel { content: [back]
        layoutInfo: LayoutInfo {
            maxHeight: 220
            maxWidth: 150
            width: 150
            height: 220}
    };

    public var updater = AsyncTask {
        run: function() {
           while(myScene.running) {
               try {
                   if (not myScene.running) break;
                   updateVisitors();
                   Thread.sleep(30000);
               } catch(ex : InterruptedException) {
               }
           }
        }
        onDone: function() {println("bye bye");}
    };

    public override function create(): Node {
        hide();
        return Stack {
            content: [
        bg,
        VBox {
            content: [
                HBox {
                    height: 32
                    spacing : 4
                    content: [
                        HBox {
                            translateX: 3
                            translateY: 3
                            content: [
                                pathButton,
                                niceButton
                                ]
                        }
                    ]
                }
                map
            ]
        }
        ]
        }
    }

    public function initMap() {
       var minx: Float = 0;
       var maxx: Float = 0;
       var miny: Float = 0;
       var maxy: Float = 0;
       var shapes: Shape[] = myScene.getShapes();
       for (a in shapes) {
           var mp: MapPoint = MapPoint{};
           mp.shape = a;
           mp.panel = this;
           mp.label = myScene.topPanel.label;
           insert mp into mapPanos;

           if (minx > a.getMapcoordinates()[0]) minx = a.getMapcoordinates()[0];
           if (maxx < a.getMapcoordinates()[0]) maxx = a.getMapcoordinates()[0];
           if (miny > a.getMapcoordinates()[2]) miny = a.getMapcoordinates()[2];
           if (maxy < a.getMapcoordinates()[2]) maxy = a.getMapcoordinates()[2];
       }

       var xscale: Float = width / (maxx - minx);
       var yscale: Float = height / (maxy - miny);

       if (xscale < yscale) scale = xscale
       else scale = yscale;

       xoffset = ((-1)*minx);
       yoffset = ((-1)*miny);

       insert pathlines into map.content;

       for (a in mapPanos) {
           a.setShape();
           insert a into map.content;
           if (a.shape.getFirst()) {
               activePano = a;
           }
       }

       insert compass into map.content;
    }

    public function loadFirst(): Void {
        activePano.setFirst();
        insert [activePano.point.translateX, activePano.point.translateY] into pathlines.points;

       startUpdateVisitors();
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

    public function setActive(mp: MapPoint) {
        activePano = mp;
        insert mp into path;
        insert [activePano.point.translateX, activePano.point.translateY] into pathlines.points;
    }

    public function getActive() : MapPoint {
        return activePano;
    }

    /**
    * zmena panoramy podla Shape objektu
    */
    public function changePano(sp: Shape): Void {
        for (mp in mapPanos) {
            if (mp.shape.getTitle() == sp.getTitle()) {
                mp.changeActive();
                return;
            }
        }
    }

    /**
    * zmena panoramy podla mena, pozitie pri volani z extension
    */
    public function changePano(title: String): Void {
        for (mp in mapPanos) {
            if (mp.shape.getTitle() == title) {
                mp.setActive();
                return;
            }
        }
    }

    public function updateCompass(pos: Double[], rot: Double) {
        var x: Float = pos[0] + xoffset;
        var y: Float = pos[1] + yoffset;
        x = x * scale;
        y = y * scale;
        compass.translateX = x;
        compass.translateY = y;
        rotation.angle = rot;
    }

    /**
    * updatovanie stringov pri zmene jazyka
    */
    public function updateLang(){
         pathButton.primary.text = ##"HidePath";
         pathButton.secondary.text = ##"ShowPath";
         niceButton.primary.text = ##"HideNice";
         niceButton.secondary.text = ##"ShowNice";
         activeVisitos = ##"Active vistors";
    }

    public var dataloader: DataLoader = DataLoader {scene: myScene};

    public function startUpdateVisitors(): Void {
        updater.start();
    }

    /**
    * nacita aktualnych navstevnikov
    */
    public function updateVisitors(): Void {
        dataloader.action = "activeusers";
        dataloader.input = [];
        dataloader.load(2);
        var pit = dataloader.values.iterator();
        for (m in mapPanos) {
            if (pit.hasNext()) {
                var pom = pit.next();
                m.actUsers = Integer.parseInt(pom.value);
            }
        }
    }


}
