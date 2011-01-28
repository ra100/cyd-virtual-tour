/*
 * SceneFX.fx
 *
 * Created on 20.3.2010, 20:15:04
 */

package sk.ra100.cyd.main;
import javafx.scene.control.ProgressIndicator;
import javafx.scene.effect.SepiaTone;
import javafx.stage.Stage;
import java.lang.Math;
import sk.ra100.cyd.UI.ExtensionDisplay;
import javafx.scene.Scene;
import javafx.scene.paint.Color;
import javafx.stage.StageStyle;
import sk.ra100.cyd.UI.TopPanel;
import javafx.scene.layout.Flow;
import javafx.geometry.HPos;
import javafx.geometry.VPos;
import sk.ra100.cyd.UI.RightPanel;
import java.util.Locale;
import javafx.scene.shape.Rectangle;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.Panel;
import javafx.scene.input.KeyEvent;
import javafx.scene.shape.Polyline;

/**
 * @author ra100
 */

public class PanoScene {

    public def SK = "sk";
    public def EN = "en";

    // loading indicator
    package var loaded: Integer = 0;
    public var block = false;

    // Frame size
    public-read var screenWidth: Number = 700;
    public-read var screenHeight: Number = 500;

    public-read var language: String = SK;

    def progressIndicator: ProgressIndicator = ProgressIndicator {
        progress: -1
        scaleX : 6
        scaleY : 6
        visible: bind universeFX.loaderVisible
        effect:SepiaTone {
	level: 0.5
        }
    }

    def progressIndicatorPerc: ProgressIndicator = ProgressIndicator {
        scaleX : 3
        scaleY : 3
        visible: bind universeFX.loaderVisible
        progress: bind ProgressIndicator.computeProgress( 100,
            loaded)
    }

    public var extensionDisplay: ExtensionDisplay = bind universeFX.extension;

    var topPanel = TopPanel {
        visible: bind block
        disable: bind extensionDisplay.visible;
    }


    var exitPanel = RightPanel{
        visible: bind not extensionDisplay.visible;
        myScene : this
    }

     // Frame
    var stage: Stage;

    // FXCanvas3D
    def fxCanvas3DComp = FXCanvas3DSBComp {
        // Resizing
        width: bind Math.max(stage.scene.width, 10);    // avoid width <= 0
        height: bind Math.max(stage.scene.height, 10);  // avoid height <= 0
    }

    // UniverseFX
    public def universeFX = UniverseFX {
        // Callback of AsyncOperation
        initUniverse: function(universe: PanoUniverse): Void {
            //
            fxCanvas3DComp.isScreenSize = false;
            fxCanvas3DComp.frame = stage;
            // Finish FXCanvas3DComp
            fxCanvas3DComp.initFXCanvas3D(universe);
            // Show frame
            stage.visible = true;
        }
    }

//    var debug = Rectangle {
//        visible: true
//	x: 699, y: 499
//	width: 1, height: 1
//	fill: Color.BLACK
//    }

    var debug = Polyline {
	points : [ 0,0, 700,0, 700,500, 0,500, 0,0 ]
	strokeWidth: 1.0
	stroke: Color.BLACK
    }

    var debug2 = Rectangle {
	x: 0, y: 0
	width: 700, height: 500
	fill: Color.WHITE
        opacity: 0.0
    }

    var panel = Panel {
        width : 700
        height: 500
        content: [debug2, debug]
        onMouseMoved: function( e: MouseEvent ):Void {
            updateScreen();
        }
        onMouseEntered: function( e: MouseEvent ):Void {
            updateScreen();
        }
        onMouseExited: function( e: MouseEvent ):Void {
            updateScreen();
        }
        onMouseReleased: function( e: MouseEvent ):Void {
            updateScreen();
        }
        onMouseDragged: function (e: MouseEvent): Void {
            updateScreen();
        }
        onMouseClicked: function (e: MouseEvent): Void {
            updateScreen();
        }
        onKeyPressed: function (e: KeyEvent): Void {
            updateScreen();
        }
        onKeyTyped: function (e: KeyEvent): Void {
            updateScreen();
        }
        onKeyReleased: function( e: KeyEvent ):Void {
            updateScreen();
        }
    }

    public function deleteExt(){
        universeFX.deleteExt();
    }

    public function create(){
        //db.connect();
        universeFX.setScene(this);
        extensionDisplay.visible = false;
        topPanel.myScene = this;

        progressIndicator.translateX = screenWidth/2 - progressIndicator.width/2;
        progressIndicator.translateY = screenHeight/2 - progressIndicator.height/2;

        progressIndicatorPerc.translateX = screenWidth/2 - progressIndicatorPerc.width/2;
        progressIndicatorPerc.translateY = screenHeight/2 - progressIndicatorPerc.height/2;

        stage = Stage {
        title: "Virtuálna prehliadka: Brhlovce"

        style: StageStyle.UNDECORATED

        fullScreen: false
        resizable: true
        visible: true

        width: screenWidth
        height: screenHeight

        scene: Scene {
            fill: Color.TRANSPARENT // Color.TRANSPARENT | null
            content: [
                    fxCanvas3DComp,
                    progressIndicator,
                    
            Flow {
                hpos: HPos.LEFT
                vpos: VPos.TOP
                content: [
                        topPanel
                        ]
            }
            Flow {
                translateX : screenWidth - 42;
                content: [
                        exitPanel
                        ]
            }
               panel,
               extensionDisplay
            ]
        }
    }

    //
    // Start
    //
    // JavaTaskBase
    universeFX.start();
    }

    public function showCenters(){
        universeFX.showCenters();
    }

    public function hideCenters(){
        universeFX.hideCenters();
    }

    public function showExtras(){
        universeFX.showExtras();
    }

    public function hideExtras() {
        universeFX.hideExtras();
    }

    public function getTrace():String{
        return universeFX.getTrace();
    }

    public function changeLanguage(lang: String){
        Locale.setDefault(new Locale(lang));
        language = lang;
    }

    public function disable(){
        exitPanel.visible = false;
    }

    public function enable() {
        exitPanel.visible = true;
    }

    public function updateScreen(){
        debug.stroke = Color.WHITE;
        debug.stroke = Color.BLACK;
    }

}
