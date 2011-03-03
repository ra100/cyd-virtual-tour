/*
 * SceneFX.fx
 *
 * Created on 20.3.2010, 20:15:04
 */

package net.ra100.cyd.main;
import javafx.scene.control.ProgressIndicator;
import javafx.scene.effect.SepiaTone;
import javafx.stage.Stage;
import java.lang.Math;
import net.ra100.cyd.UI.ExtensionDisplay;
import javafx.scene.Scene;
import javafx.scene.paint.Color;
import javafx.stage.StageStyle;
import net.ra100.cyd.UI.TopPanel;
import javafx.scene.layout.Flow;
import javafx.geometry.HPos;
import javafx.geometry.VPos;
import net.ra100.cyd.UI.RightPanel;
import java.util.Locale;
import javafx.scene.shape.Rectangle;
import javafx.scene.layout.Panel;
import javafx.scene.image.ImageView;
import javafx.scene.effect.GaussianBlur;
import javafx.animation.transition.ScaleTransition;
import javafx.animation.Timeline;
import net.ra100.cyd.UI.MapPanel;
import net.ra100.cyd.scene.Shape;
import net.ra100.cyd.utils.DataLoader;
import java.util.logging.Logger;
import java.util.logging.Level;
import net.ra100.cyd.utils.DataElement;

/**
 * @author ra100
 */

public class PanoScene {

    public def SK = "sk";
    public def EN = "en";

    var stylesheets : String = "{__DIR__}default.css";

    // loading indicator
    package var loaded: Integer = 0;
    public var block = false;

    // Frame size
    public-read var screenWidth: Number = 700;
    public-read var screenHeight: Number = 500;

    public-read var language: String = SK;

    /* security identifikatory pre zapis do DB a identifikaciu usera */
    public-read var id: Integer;
    public-read var token: String;

    public var dataloader: DataLoader = DataLoader {scene: this};

    def progressIndicator: ProgressIndicator = ProgressIndicator {
        progress: -1
        scaleX : 6
        scaleY : 6
        visible: bind universeFX.loaderVisible
        effect:SepiaTone {
	level: 0.5
        }
    }

    public var progressBackground : ImageView = ImageView {
        visible: bind universeFX.loaderVisible
        image: null
        preserveRatio: false
        opacity: 1.0
        effect: GaussianBlur {
                radius: 10
                }
    }


    def progressIndicatorPerc: ProgressIndicator = ProgressIndicator {
        scaleX : 3
        scaleY : 3
        visible: bind universeFX.loaderVisible
        progress: bind ProgressIndicator.computeProgress(100, loaded)
    }

    public var extensionDisplay: ExtensionDisplay = bind universeFX.extension;

    var topPanel = TopPanel {
        visible: bind block
        disable: bind extensionDisplay.visible;
    }


    var exitPanel = RightPanel {
        visible: bind not extensionDisplay.visible;
        myScene: this;
    }

    var mapPanel = MapPanel {
        visible: bind block;
        disable: bind extensionDisplay.visible;
        myScene: this;
    }


     // Frame
    var stage: Stage;

    // FXCanvas3D
    public-read def fxCanvas3DComp = FXCanvas3DSBComp {
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
            fxCanvas3DComp.initFXCanvas3D(universe,this);
            // Show frame
            stage.visible = true;
        }
    }

    /* odstranenie problemu s tym, ze sa nerefreshuje obraz, ked je ako applet */
    var debug2 = Rectangle {
	x: 0, y: 0
	width: screenWidth, height: screenHeight
	fill: Color.WHITE
        opacity: 0.0
    }

    /* panel pre refreshovaci fix */
    var panel = Panel {
        width : screenWidth
        height: screenHeight
        content: [debug2]
    }

    public function deleteExt(){
        universeFX.deleteExt();
    }

    public function create(){
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
        resizable: false
        visible: true

        width: screenWidth
        height: screenHeight

        scene: Scene  {
            stylesheets: bind stylesheets
            fill: Color.TRANSPARENT // Color.TRANSPARENT | null
            content: [
                    fxCanvas3DComp,
                    progressBackground,
                    progressIndicator,
                    
            Flow {
                hpos: HPos.LEFT
                vpos: VPos.TOP
                content: [
                        topPanel
                        ]
                onMouseDragged: function(event) {
                    stage.x += event.dragX;
                    stage.y += event.dragY;
                  }
            }
            Flow {
                hpos: HPos.LEFT
                vpos: VPos.TOP
                translateY : 80;
                content: [
                        mapPanel
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
    
    changeLanguage(SK);
    topPanel.updateLang();

    //
    // Start
    //
    // JavaTaskBase
    universeFX.start();

    // stale sa prekresluje, riesi to problem s neprekreslovanim v browseroch
    ScaleTransition {
	duration: 20s
	node: debug2
	byX: 1.1 byY: 1.1
	repeatCount: Timeline.INDEFINITE
        autoReverse: true
    }.play();

    }

    public function showCenters(){
        mapPanel.show();
//        universeFX.showCenters();
    }

    public function hideCenters(){
        mapPanel.hide();
//        universeFX.hideCenters();
    }

    public function showExtras(){
        universeFX.showExtras();
    }

    public function hideExtras() {
        universeFX.hideExtras();
    }

    public function changeLanguage(lang: String){
        Locale.setDefault(new Locale(lang));
        language = lang;
    }

    /**
    * nacitanie ID z databazy, vytvorenie paru token +id, prepojenie na panoramu
    */
    function userInit() {
        var random = new java.util.Random();
        token = Float.toString(random.nextFloat());
        dataloader.action = 'init';
        dataloader.input = [DataElement {value: mapPanel.activePano.getTitle(), key: "panoname"}];
        dataloader.load(0);
        id = Integer.parseInt(dataloader.getValueByKey('id'));
        Logger.getLogger("net.ra100.cyd").log(Level.INFO, "My ID: {id}");
    }

    /* inicializacia po nacitani sceny */
    public function firstInit() {
        mapPanel.initMap();
        userInit();
    }

    /* zmeni panoramu podla instancie Shape */
    public function changeShape(sp: Shape) {
        universeFX.changeShape(sp);
    }

    public function getShapes(): Shape[] {
        return universeFX.universe.getShapesArray();
    }

    public function updateMap(): Void {
        mapPanel.changePano(universeFX.universe.getShape())
    }

}
