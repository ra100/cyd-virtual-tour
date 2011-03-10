package net.ra100.cyd.utils;

import javafx.data.pull.PullParser;
import javafx.data.pull.Event;
import net.ra100.cyd.main.PanoScene;
import java.lang.StringBuffer;
import java.util.logging.Logger;
import java.util.logging.Level;
import java.io.InputStream;

/**
 * nacitavanie udajov zo stranky/databazy
 * @author ra100
 */

public class DataLoader {

    public def INIT = "init";
    public def EXTENSION = "extension";

    public var baseURL: String = "http://brhlovce.ra100.net/sites/brhlovce/misc/scripts/action.php";
    public var values: DataElement[];
    public var scene: PanoScene;
    public var action: String;
    public var input: DataElement[];

    var url : String;

    var parser = PullParser {
        documentType: PullParser.XML;
        onEvent: function(event: Event) {
            if (event.type == PullParser.END_ELEMENT) {
                var de = DataElement {
                    key: event.qname.name;
                    value: event.text;
                }
                de.value.replace({'[';']'}, {'<';'>'});
                insert de into values;
            }
        }
    }

    var gbitem: GuestBook;
    public var gblist = new GuestBookList();
    var gbparser = PullParser {
        documentType: PullParser.XML;
        onEvent: function(event: Event) {
            if (event.type == PullParser.START_ELEMENT){
                if (event.qname.name == "comment") {
                    gbitem = new GuestBook();
                }
            }
            if (event.type == PullParser.END_ELEMENT) {
                if (event.qname.name == "time") {
                    gbitem.time = event.text;
                } else if (event.qname.name == "name") {
                    gbitem.name = event.text;
                } else if (event.qname.name == "text") {
                    gbitem.text = event.text;
                } else if (event.qname.name == "comment") {
                    gblist.addItem(gbitem);
                } else if (event.qname.name == "rowcount") {
                    gblist.setCount(event.text);
                }
            }
        }
    }

    public function load(reload: Integer): Boolean{
        values = [];
        var language = scene.language;
        var id = scene.id;
        var token = scene.token;
        var vals: StringBuffer = new StringBuffer();
        var i = 0;
        if ((action == "submitpost") or (action == "score")) input = safeStrings(input);
        for (val in input) {
            i++;
            vals.append("&{val.key}={val.value}");
        }
        vals.append("&count={i}");

        url = "{baseURL}?action={action}&language={language}&id={id}&token={token}{vals.toString()}";
        Logger.getLogger("net.ra100.cyd").log(Level.INFO, url);
        var uis: InputStream;

        try {
            uis = Helper.urlInputStreamEx(url);
            if (action == "guestbook") {
                gbparser.input = uis;
                gbparser.parse();
            } else {
                parser.input = uis;
                parser.parse();
            }
        } catch (e) {
            if (uis == null and reload < 2) {
                //automaticky reload ak zlyha pripojenie

                scene.messagePanel.label.content = ##"Connection Error";
                scene.messagePanel.refresh.visible = true;
                scene.messagePanel.refresh.action = function(): Void {
                    load(reload+1);
                }
                scene.messagePanel.visible = true;
            }
        } finally {
            uis.close();
        }
        return true;
    }

    public function loadGuestbook(page: Integer): GuestBook[] {
        gblist.reset();
        action = "guestbook";
        input = [DataElement {key: "page", value: page.toString()}];
        load(0);
        return gblist.getItems();
    }


    /**
    * zmeni specialne znaky aby nerobili problemy v URL
    * input: String[] - vstupne pole retazcov
    * return String[]
    */
    public function safeStrings(input: DataElement[]): DataElement[] {
        for (val in input) {
            val.value = val.value.replace("%", "%25");
            val.value = val.value.replace(" ", "%20");
            val.value = val.value.replace("&", "%26");
            val.value = val.value.replace('?', "%3F");
            val.value = val.value.replace("=", "%3D");
            val.value = val.value.replace("'", "%27");
            val.value = val.value.replace('"', "%22");
            val.value = val.value.replace('\\',"%5C");
            println(val.value);
        }
        return input;
    }

    public function getValueByKey(key: String): String {
        for (a in values) {
            if (a.key == key) {return a.value;}
        }
        return null;
    }

    /**
    do pola DataElement[] nacita items, key - iid, value - typeid
    */
    public function getItemsIds(): DataElement[] {
        var de: DataElement[];
        var it = values.iterator();
        while (it.hasNext()) {
            var val = it.next();
            if (val.key == 'iid') {
                insert DataElement {
                    key: val.value
                    value: it.next().value
                } into de;
            }
        }
        return de;
    }

    /* spravi zoznam highscores*/
    public function getHighscore(): DataElement[] {
        var de: DataElement[];
        var it = values.iterator();
        while (it.hasNext()) {
            var val = it.next();
            if (val.key == 'time') {
                insert DataElement {
                    value: val.value
                    key: it.next().value
                    type: 1
                } into de;
            }
            if (val.key == 'panos') {
                insert DataElement {
                    value: val.value
                    key: it.next().value
                    type: 2
                } into de;
            }
            if (val.key == 'extensions') {
                insert DataElement {
                    value: val.value
                    key: it.next().value
                    type: 3
                } into de;
            }
        }
        return de;
    }

}
