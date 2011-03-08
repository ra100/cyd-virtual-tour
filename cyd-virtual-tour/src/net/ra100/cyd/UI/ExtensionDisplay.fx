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
import javafx.scene.text.Text;
import javafx.scene.text.TextAlignment;
import net.ra100.cyd.UI.res.ExitButton;
import javafx.scene.effect.Glow;
import net.ra100.cyd.utils.DataElement;
import net.ra100.cyd.UI.res.StarButton;
import javafx.scene.layout.Tile;
import javafx.scene.Group;
import javafx.geometry.HPos;
import javafx.scene.control.Label;

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

    /*items v extension */
    public var items: Item[];

    // load the image
    var image = new Image();

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

   var starButton =  RButton {
        translateX: 630;
        translateY: 20;
        image: StarButton { };
        visible: false
        overEffect: Glow {
            level: 1
        }
        action: function (): Void {
            hideItems();
        }
    }

    var itemsPanel: Tile = Tile {
        layoutX: 5
        layoutY: 5
        visible: false
        hgap: 5
        vgap: 5
        columns: 7
        rows: 2
        content: bind items
    }

    var scoreboard: Group = Group {
            layoutX: 30
            layoutY: 40
        };

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
            itemsPanel.visible = false;
            myScene.bagPanel.visible = false;
            scoreboard.visible = false;
            myScene.deleteExt();
        }
    };

    public override function create(): Node {
        return panel = Panel {
            content: [
                background,
                background2,
                imageView,
                textHeader,
                text,
                guestBook,
                scoreboard,
                itemsPanel,
                starButton,
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
        textHeader.content = myScene.dataloader.getValueByKey('titlen');
        text.content = myScene.dataloader.getValueByKey('content');
        url = myScene.dataloader.getValueByKey('url');

        if (type == "image") {setImage();}
        else if(type == "text") {
            setText();
        } else if (type == "guestbook") {
            guestBook.reloadlang();
            guestBook.load();
            guestBook.visible = true;
        }
        if (type == "highscores") {
            textHeader.visible = true;
            loadScores();
        }
        itemsPanel.visible = false;
        setItems();
    }

    /* nastavenie items */
    function setItems(): Void {
        items = [];

        for (de in myScene.dataloader.getItemsIds()) {
            loadItem(Integer.parseInt(de.key), Integer.parseInt(de.value));
        }

        if (items.size() > 0) {
            starButton.visible = true;
        } else {
            starButton.visible = false;
        }

    }

    /* relaod itemov v extension */
    public function reloadItems(): Void {
        myScene.dataloader.action = 'loadextension';
        myScene.dataloader.input = [DataElement {value: extension.getName(), key: "extensionname"}];
        myScene.dataloader.load(0);

        setItems();
    }

    /* skyje alebo zobrazi itemy */
    function hideItems() {
        if (itemsPanel.visible == false) {

            itemsPanel.visible = true;
            myScene.bagPanel.visible = true;
        } else {
            itemsPanel.visible = false;
            myScene.bagPanel.visible = false;
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
        imageView.visible = true;

    }

    public function setText() {
        text.visible = true;
        textHeader.visible = true;
    }

    public function getExtension():PanoExtension {
        return extension;
    }

    public function loadItem(iid: Integer, tid: Integer) {
        insert Item {
            itemid: iid
            type: myScene.getItemTypeById(tid)
            myScene: myScene
            status: -1
        } into items;
    }

    public function ename(): String {
        return this.extension.getName();
    }

    public function showitems() {
        itemsPanel.visible = true;
        starButton.visible = true;
    }

    public function loadScores(): Void {
        var tile = Tile {
            hgap: 8
            vgap: 4
            rows: 2
            columns: 3
            tileWidth: 190
            autoSizeTiles: false
            nodeHPos: HPos.LEFT
            content: [
                Label {text: ##"By time", id: "scoretitle"},
                Label {text: ##"By pano", id: "scoretitle"},
                Label {text: ##"By ext", id: "scoretitle"}]
        }

        var timetile = Tile {
            columns: 2
            rows: 10
            vgap: 4
            nodeHPos: HPos.LEFT
            tileWidth: 80
            tileHeight: 20
            autoSizeTiles: false
        }

        var panotile = Tile {
            columns: 2
            rows: 10
            vgap: 4
            nodeHPos: HPos.LEFT
            tileWidth: 80
            tileHeight: 20
            autoSizeTiles: false
        }

        var exttile = Tile {
            columns: 2
            rows: 10
            vgap: 4
            nodeHPos: HPos.LEFT
            tileWidth: 80
            tileHeight: 20
            autoSizeTiles: false
        }

        insert timetile into tile.content;
        insert panotile into tile.content;
        insert exttile into tile.content;

        var it = myScene.dataloader.getHighscore().iterator();
        while (it.hasNext()) {
            var d = it.next();
            if (d.type == 1) {
                insert Label {text: d.key, id: "scorename"} into timetile.content;
                insert Label {text: d.value, id: "scoredata"} into timetile.content;
            } else if (d.type == 2) {
                insert Label {text: d.key, id: "scorename"} into panotile.content;
                insert Label {text: d.value, id: "scoredata"} into panotile.content;
            } else if (d.type == 3) {
                insert Label {text: d.key, id: "scorename"} into exttile.content;
                insert Label {text: d.value, id: "scoredata"} into exttile.content;
            }
        }
        
        scoreboard.content = [tile];
        scoreboard.visible = true;
    }
}
