/*
 * ExtensionDisplay.fx
 *
 * Created on 20.3.2010, 17:27:38
 */

package sk.ra100.cyd.UI;

import sk.ra100.cyd.scene.PanoExtension;
import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.Panel;
import sk.ra100.cyd.main.PanoScene;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.scene.effect.GaussianBlur;
import javafx.stage.Stage;
import javafx.stage.StageStyle;
import javafx.scene.Scene;
import javafx.scene.text.Text;
import javafx.scene.text.TextAlignment;
import sk.ra100.cyd.UI.res.ExitButton;
import javafx.scene.effect.Glow;
/**
 * @author ra100
 */

public class ExtensionDisplay extends CustomNode {

    var extension: PanoExtension = null;
    var myScene : PanoScene;
    def border : Number = 16;
    
    //vyska a sirka contentu
    var height : Number;
    var width : Number;

    // load the image
    var image = new Image();

    public var textName : String;

    var guestBook = GuestBookRead{
        visible: false;
    }

    var textHeader = Text {
        x: border,
        y: border+14,
        smooth: false
        fill: Color.BLACK
        wrappingWidth: 500
        style: "font-family: 'Verdana'; font-size: 16pt"
    }

    var text = Text {
	x: border,
        y: border+40,
        smooth: false
        fill: Color.BLACK
        textAlignment: TextAlignment.JUSTIFY
        style: "font-family: 'Verdana';font-size: 14pt"
   }

    var imageView = ImageView {
        visible: true
        image: bind image
        preserveRatio: true
        smooth: true
    }

    var imageViewBG = ImageView {
        visible: true
        image: bind image
        preserveRatio: false
        effect: GaussianBlur {
            radius: 10
        }
        opacity: 1.0
    }

    var background = Rectangle {
	x: 0
        y: 0
	width: bind myScene.screenWidth
        height: bind myScene.screenHeight
	fill: Color.BLACK
        opacity: 0.5
    }
    var background2 = Rectangle {
	x: border-5
        y: border-5
        arcWidth: 20
        arcHeight: 20
	width: bind myScene.screenWidth-(border*2)+10
        height: bind myScene.screenHeight-(border*2)+10
	fill: Color.ALICEBLUE
        opacity: 0.8
    }

    def closeButton = RButton {
                translateX: 636;
                translateY: -16;
                image: ExitButton { }
                overEffect: Glow {
                    level: 1
                }
                action: function (): Void {
                    this.visible = false;
                    guestBook.visible = false;
                    text.visible = false;
                    textHeader.visible = false;
                    imageView.visible = false;
                    imageViewBG.visible = false;
                    myScene.deleteExt();
                }
            };

    public override function create(): Node {
            return Panel {
                        content: [
                                background,
                                background2,
                                imageViewBG,
                                imageView,
                                textHeader,
                                text,
                                guestBook,
                                closeButton]
                };
                }

    public function setScene(sc: PanoScene){
        myScene = sc;
    }

    public function setExtension(pe : PanoExtension) {
        extension = pe;
        if (pe.getType() == pe.IMAGE) {setImage();}
        else if (pe.getType() == pe.TEXT) {
            textName = pe.getName();
            setText();
        } else if (pe.getType() == 3) {
            guestBook.reloadlang();
            guestBook.load();
            guestBook.visible = true;
        }
    }

    function setImage(){
        if (extension.getImage() == null) {
            image = Image{
                url: extension.getUrl()
            }
            extension.setImage(image);
        } else {
            image = extension.getImage();
        }

        if (myScene.screenHeight-(border*2) < image.height) {
            imageView.fitHeight = myScene.screenHeight-(border*2);
        } else {
            imageView.fitHeight = 0;
        }

        if (myScene.screenWidth-(border*2) < image.width) {
            imageView.fitWidth = myScene.screenWidth-(border*2);
        } else {
            imageView.fitWidth = 0;
        }
        height = imageView.boundsInLocal.height;
        width = imageView.boundsInLocal.width;
        imageView.translateX = myScene.screenWidth/2 - width/2;
        imageView.translateY = myScene.screenHeight/2 - height/2;
        imageViewBG.fitHeight = myScene.screenHeight;
        imageViewBG.fitWidth = myScene.screenWidth;
        imageView.visible = true;
        imageViewBG.visible = true;

    }

    public function setText() {
        var ext : ExpoText = new ExpoText();
        ext.create(textName, myScene.language);
        textHeader.content = ext.title;
        text.content = ext.content;
        println(textHeader.content);
        text.wrappingWidth = myScene.screenWidth-border*2-5;
        text.visible = true;
        textHeader.visible = true;
    }


    function createStage(){
        Stage {

        style: StageStyle.UNDECORATED

        fullScreen: false
        resizable: true
        visible: true

        scene: Scene {
            fill: Color.TRANSPARENT // Color.TRANSPARENT | null
            content: [
                this
            ]

            }
        }
    }

    public function getExtension():PanoExtension {
        return extension;
    }



}
