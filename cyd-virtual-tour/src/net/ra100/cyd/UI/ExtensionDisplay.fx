/*
 * ExtensionDisplay.fx
 *
 * Created on 20.3.2010, 17:27:38
 */

package net.ra100.cyd.UI;

import net.ra100.cyd.scene.PanoExtension;
import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.Panel;
import net.ra100.cyd.main.PanoScene;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.scene.effect.GaussianBlur;
import javafx.stage.Stage;
import javafx.stage.StageStyle;
import javafx.scene.Scene;
import javafx.scene.text.Text;
import javafx.scene.text.TextAlignment;
import net.ra100.cyd.UI.res.ExitButton;
import javafx.scene.effect.Glow;
import net.ra100.cyd.utils.DataElement;
import net.ra100.cyd.utils.DataLoader;
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

    var type: String;
    var url: String;

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
        id : "headerText"
    }

    var text = Text {
	x: border,
        y: border+40,
        smooth: false
        fill: Color.BLACK
        textAlignment: TextAlignment.JUSTIFY
        wrappingWidth: 500
        id: "longText"
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

    var panel: Panel;

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
            return panel = Panel {
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
        myScene.dataloader.action = 'loadextension';
        myScene.dataloader.input = [DataElement {value: extension.getName(), key: "extensionname"}];
        myScene.dataloader.load(0);
        type = myScene.dataloader.getValueByKey('type');
        textHeader.content = myScene.dataloader.getValueByKey('title');
        text.content = myScene.dataloader.getValueByKey('content');
        url = myScene.dataloader.getValueByKey('url');

        if (type == "image") {setImage();}
        else if(type == "text") {
            textName = pe.getName();
            setText();
        } else if (type == "guestbook") {
            guestBook.reloadlang();
            guestBook.load();
            guestBook.visible = true;
        }
    }

    function setImage(){
        if (extension.getImage() == null) {
            image = Image{
                url: url
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
        text.visible = true;
        textHeader.visible = true;
    }

    public function getExtension():PanoExtension {
        return extension;
    }



}
