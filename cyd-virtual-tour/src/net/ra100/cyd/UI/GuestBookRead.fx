/*
 * ExpoText.fx
 *
 * Created on 23.3.2010, 22:42:56
 */
package net.ra100.cyd.UI;

import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.scene.Group;
import javafx.scene.layout.VBox;
import javafx.scene.layout.HBox;
import javafx.scene.control.Label;
import javafx.scene.control.TextBox;
import javafx.scene.text.Text;
import javafx.scene.image.ImageView;
import javafx.scene.image.Image;
import javafx.scene.paint.Color;
import net.ra100.cyd.main.PanoScene;
import net.ra100.cyd.utils.GuestBook;
import net.ra100.cyd.utils.DataElement;
import javafx.scene.layout.LayoutInfo;

/**
 * @author ra100
 */
public class GuestBookRead extends CustomNode {

    var textHeader = Text {
        smooth: false
        fill: Color.BLACK
        wrappingWidth: 700
        id: "headerText"
        content: ##"Guestbook";
    }
    
    public var myScene: PanoScene;
    public var array: GuestBook[];

    override protected function create(): Node {
        return Group {
                    content: [VBox {
                            translateX: 26
                            translateY: 16
                            content: [
                                textHeader,
                                VBox {
                                    spacing: 4
                                    content: bind for (a in array) [
                                            Text { translateY: 4
                                                content: "{a.time} :: {a.name}"
                                                id: "commentName"

                                            }
                                            Text {
                                                wrappingWidth: 650
                                                content: a.text
                                                id: "comment"
                                            }
                                        ]
                                }
                                HBox {
                                    translateY: 12
                                    content: [
                                        prevButton,
                                        nextButton
                                    ]
                                }
                                VBox {
                                    translateY: 16
                                    content: [nameLabel,
                                                    name,
                                                    message,
                                            textfield, submit,]
                                        }
                                    
                            ]
                        }]
                }
    }

    def prevButton = RButton {
                image: ImageView {
                image: Image {
                        url: "{__DIR__}res/PrevButton.png"
                }
            }
        action: function () {
            prevPage();
        }
    }

    def nextButton = RButton {
                image: ImageView {
                image: Image {
                        url: "{__DIR__}res/NextButton.png"
                }
            }
        action: function () {
            nextPage();
        }
    }

    var message = Label {
            text: ##"Message"
    }
    
    var nameLabel = Label {
            text: ##"Name"
    }

    var name = TextBox  {
        selectOnFocus: true
	columns: 16
	editable: true
        layoutInfo: LayoutInfo {
                width: 120
                maxWidth: 120
                }
    }

    var textfield = TextBox {
	promptText: ##"Write your comment here"
	columns: 54
	selectOnFocus: true
        editable: true
        multiline: true
        lines: 2
        layoutInfo: LayoutInfo {
                width: 200
                maxWidth: 200
                }
    }

    var submit = RButton {
	image: ImageView {
                image: Image {
                        url: "{__DIR__}res/OkButton.png"
                }
            }
	action: function() { submitPost(); }
    }

    var page = 0;

    public function load(){
        array = myScene.dataloader.loadGuestbook(page);
    }

    function submitPost(){
        myScene.dataloader.action = "submitpost";
        myScene.dataloader.input = [DataElement{ key: "name", value: name.rawText},
            DataElement{ key: "text", value: textfield.rawText}];
        myScene.dataloader.load(0);
        page = 0;
        load();
        textfield.text = "";
        name.text = "";
    }

    function prevPage(){
        if (page > 0) {
            page=page-1;
            load();
        }
    }

    function nextPage(){
        if (page < (array.size()/7)) {
            page=page+1;
            load();
        }

    }

    public function reloadlang(){
        textfield.promptText = ##"Write your comment here";
        textHeader.content = ##"Guestbook";
        name.promptText = ##"Name";
        nameLabel.text = ##"Name";
        message.text = ##"Message";
    }
}

