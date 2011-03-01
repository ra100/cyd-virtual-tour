/*
 * ExpoText.fx
 *
 * Created on 23.3.2010, 22:42:56
 */
package net.ra100.cyd.UI;

import javafx.data.pull.PullParser;
import javafx.data.pull.Event;
import net.ra100.cyd.utils.Helper;
import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.scene.Group;
import javafx.scene.layout.VBox;
import javafx.scene.layout.HBox;
import javafx.scene.control.Label;
import java.lang.Exception;
import javafx.scene.control.TextBox;
import javafx.scene.text.Text;
import javafx.scene.image.ImageView;
import javafx.scene.image.Image;
import javafx.scene.paint.Color;

/**
 * @author ra100
 */
public class GuestBookRead extends CustomNode {

    var textHeader = Text {
        smooth: false
        fill: Color.BLACK
        wrappingWidth: 500
        id: "headerText"
        content: ##"Guestbook";
    }

    override protected function create(): Node {
        return Group {
                    content: [VBox {
                            translateX: 16
                            translateY: 16
                            content: [
                                textHeader,
                                VBox {
                                    spacing: 4
                                    content: bind for (a in array) [
                                            Label { translateY: 4
                                                text: "{a.time} :: {a.name}"
                                                id: "comment"
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

    public var list = new GuestBookList();

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
    }

    var textfield = TextBox {
	text: ##"Write your comment here"
	columns: 54
	selectOnFocus: true
        editable: true
    }

    var submit = RButton {
	image: ImageView {
                image: Image {
                        url: "{__DIR__}res/SubmitButton.png"
                }
            }
	action: function() { submitPost(); }
    }

    var array: GuestBook[];
    var item: GuestBook;
    var url : String;
    var page = 0;

    var parser = PullParser {
        documentType: PullParser.XML;
        onEvent: function(event: Event) {
            if (event.type == PullParser.START_ELEMENT){
                if (event.qname.name == "comment") {
                    item = new GuestBook();
                }
            }
            if (event.type == PullParser.END_ELEMENT) {
                if (event.qname.name == "time") {
                    item.time = event.text;
                } else if (event.qname.name == "name") {
                    item.name = event.text;
                } else if (event.qname.name == "text") {
                    item.text = event.text;
                } else if (event.qname.name == "comment") {
                    list.addItem(item);
                } else if (event.qname.name == "rowcount") {
                    list.setCount(event.text);
                }
            }
        }
    }

    public function load(){
        list.reset();
        url = "http://ra100.scifi-guide.net/brhlovce/scripts/guestbook.php?page={page}";
        parser.input = Helper.urlInputStream(url);
        //httpRequest.start();
        parser.parse();
        array = list.getItems();
    }

    function submitPost(){
        var text = textfield.text.replaceAll(" ", "%20");
        name.text = name.text.replaceAll(" ", "%20");
//        if (name.text.length() == 0){
//            name.text = "anonymous";
//        }
        url = "http://ra100.scifi-guide.net/brhlovce/scripts/guestbooksub.php?name={name.text}&text={text}";
        try {
            Helper.urlInputStream(url);
        } catch( ex: Exception) {
            println("Chyba http poziadavky");
        } finally {
            page = 0;
            load();
            textfield.text = ##"Write your comment here";
            name.text = "";
        }
    }

    function prevPage(){
        if (page > 0) {
            page=page-1;
            load();
        }
    }

    function nextPage(){
        if (page < (list.count/5)) {
            page=page+1;
            load();
        }

    }

    public function reloadlang(){
        textfield.text= ##"Write your comment here";
        textHeader.content= ##"Guestbook";

    }

}

