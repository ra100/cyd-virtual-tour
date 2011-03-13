/*
 * SceneFX.fx
 *
 * Created on 20.3.2010, 20:15:04
 */

package net.ra100.cyd.main;
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
import net.ra100.cyd.UI.MessagePanel;
import javafx.scene.Group;
import net.ra100.cyd.UI.ItemType;
import javafx.scene.image.Image;
import net.ra100.cyd.scene.PanoExtension;
import javafx.scene.input.MouseEvent;
import net.ra100.cyd.UI.res.Loader;
import javafx.animation.transition.RotateTransition;
import net.ra100.cyd.utils.AsyncTask;
import net.ra100.cyd.UI.Bag;
import net.ra100.cyd.UI.BagPanel;
import net.ra100.cyd.UI.MapPoint;
import javafx.scene.Cursor;

/**
 * @author ra100
 */

public class PanoScene {

    public def SK = "sk";
    public def EN = "en";

    public def sceneurl = ##"sceneurl";

    var stylesheets : String = "{__DIR__}default.css";

    // loading indicator
    public var block = false;

    // Frame size
    public-read var screenWidth: Number = 800;
    public-read var screenHeight: Number = 600;

    public-read var language: String = SK;

    /* security identifikatory pre zapis do DB a identifikaciu usera */
    public-read var id: Integer;
    public-read var token: String;

    public var dataloader: DataLoader = DataLoader {scene: this};

    public var loader = Loader {};

    public var loaderAnim = RotateTransition {
        duration: 10s
        byAngle: 360
        repeatCount: Timeline.INDEFINITE
        node: loader
        framerate: 24
    }

    var progressIndicator: Group = Group {
        visible: true
        layoutX: 150
        layoutY: 50
        content: [loader]
    }

    /**
    pozadie pre loader identifikator
    */
    public var progressBackground : ImageView = ImageView {
        visible: bind progressIndicator.visible
        image: null
        preserveRatio: false
        opacity: 1.0
        effect: GaussianBlur {
                radius: 10
                }
    }

    public var extensionDisplay: ExtensionDisplay = bind universeFX.extension;

    public var topPanel = TopPanel {
        visible: bind block
        disable: bind extensionDisplay.visible;
        myScene: this
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

    /**
    zoznam typov itemov
    */
    public var itemtypes: ItemType[];

    /**
    * panel na chybove hlasky
    */
    public var messagePanel = MessagePanel {
        visible: false;
        myScene: this;
    }

    public var bagPanel: BagPanel = BagPanel {
        visible: false
        myScene: this
        bag: Bag { visible: true, myScene: this }
    }

     // Frame
    var stage: Stage;

    // FXCanvas3D
    public-read def fxCanvas3DComp = FXCanvas3DSBCompR {
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
//            fxCanvas3DComp.frame = stage;
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

    var scene: Scene;

    /* panel pre refreshovaci fix */
    var panel = Panel {
        width : screenWidth
        height: screenHeight
        content: [debug2]
        onMouseDragged: function(e: MouseEvent): Void {
            updateCompass();
            scene.cursor = Cursor.HAND;
        }
        onMouseReleased: function(e: MouseEvent): Void {
            scene.cursor = Cursor.DEFAULT;
        }
    }

    public function deleteExt(){
        universeFX.deleteExt();
    }

    public-read var sha: Integer;

    public function create(){
        println("Creating universe..");
        sha = FX.addShutdownAction(function(): Void {exit();});
        var exitFlow = Flow {
                translateX : screenWidth - 42;
                content: [
                        exitPanel
                        ]
            }
        scene = Scene  {
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
            },
               exitFlow,
               panel,
               extensionDisplay,
               bagPanel,
            Group {
                content: [messagePanel]
               }
            ]
        }
        if (not (FX.getArgument("javafx.applet") == null)) {
            delete exitFlow from scene.content;
        }

        stage = Stage {
            title: "Virtuálna prehliadka: Brhlovce"

            style: StageStyle.UNDECORATED

            fullScreen: false
            resizable: false
            visible: true

            width: screenWidth
            height: screenHeight

            scene: scene
        }
    showLoader();
    changeLanguage(SK);
    universeFX.setScene(this);
    extensionDisplay.visible = false;
    //
    // Start
    //
    // JavaTaskBase
    universeFX.start();
    }

    public function showCenters(){
        mapPanel.show();
    }

    public function hideCenters(){
        mapPanel.hide();
    }

    public function showExtras(){
        universeFX.showExtras();
    }

    public function hideExtras() {
        universeFX.hideExtras();
    }

    public function changeLanguage(lang: String){
        Locale.setDefault(new Locale(lang));
        bagPanel.updateLang();
        topPanel.updateLang();
        mapPanel.updateLang();
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
        AsyncTask {
            run: function() {
                loadItems();
                loadStats();
            }
            onDone: function() {
            }
        }.start();
        mapPanel.loadFirst();
        updateCompass();
        // stale sa prekresluje, riesi to problem s neprekreslovanim v browseroch
        ScaleTransition {
            duration: 20s
            node: debug2
            byX: 1.1 byY: 1.1
            repeatCount: Timeline.INDEFINITE
            autoReverse: true
            framerate: 15
        }.play();
        topPanel.activateMap();
        topPanel.activateExtras();
       
    }

    public function updateCompass() {
        mapPanel.updateCompass(universeFX.universe.getPosition(),
                    universeFX.universe.getDirection()*(-60));
    }

    /**
    nacitavanie itemtypes, ktore sa pozuiju neskor
    */
    function loadItems(): Void {
        var it = dataloader.values.iterator();
        var panos: String[];
        while (it.hasNext()) {
            var val = it.next();
            if (val.key == 'pano') {
                insert val.value into panos;
                delete val from dataloader.values;
            }
        }

        var pom: MapPoint[];
        for (val in mapPanel.mapPanos) {
                insert val into pom;
        }

        var size: Float = panos.size();
        var i: Float = size;
        for (name in panos) {
            for (mp in pom) {
                if (name == mp.getTitle()) {
                    delete mp from pom;
                    mp.point.circle.radius = (8+(12*(i/size)));
                    i--;
                    break;
                }
            }
        }
    }
    
    /**
    nacitanie poradia panoram
    */
    function loadStats(): Void {
        var it = dataloader.values.iterator();
        while (it.hasNext()) {
            var val = it.next();
            if (val.key == 'typeid') {
                insert ItemType {
                    id: Integer.parseInt(val.value)
                    name: [it.next().value, it.next().value]
                    text: [it.next().value, it.next().value]
                    image: Image{
                        url: it.next().value
                        backgroundLoading: true
                    }
                } into itemtypes;
                delete val from dataloader.values
            } else if (val.key == "pano") {
                return;
            }
        }
    }

    public function getItemTypeById(tid: Integer): ItemType {
        for (i in itemtypes) {
            if (i.id == tid) return i;
        }
        return null;
    }


    /* zmeni panoramu podla instancie Shape */
    public function changeShape(sp: Shape) {
        universeFX.changeShape(sp);
    }

    /**
    * nastaviak tivnu panoramu podla mena
    */
    public function changePano(title: String) {
        mapPanel.changePano(title);
    }


    public function getShapes(): Shape[] {
        return universeFX.universe.getShapesArray();
    }

    /*
    * updatovanie pozicie na mapke a v databaze
    */
    public function updateMap(): Void {
        mapPanel.changePano(universeFX.universe.getShape());
    }

    public function exit(): Void {
        dataloader.action = 'exit';
        dataloader.input = [DataElement {value: "", key: ""}];
        dataloader.load(0);
    }

    public function setExtension(ext: PanoExtension): Void {
        universeFX.universe.setExtension(ext);
    }

    public function setLoader(): Void {
        universeFX.loaderVisible = true;
        universeFX.startLoading();
    }

    public function showLoader(): Void {
        loaderAnim.play();
        progressIndicator.visible = true;
    }

    public function hideLoader(): Void {
        loaderAnim.pause();
        progressIndicator.visible = false;
        updateCompass();
    }

    public function initView(lo: Double, la: Double) {
        universeFX.universe.initDirection(lo, la);
    }

}
