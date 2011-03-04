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

    public function load(reload: Integer): Boolean{
        values = [];
        var language = scene.language;
        var id = scene.id;
        var token = scene.token;
        var vals: StringBuffer = new StringBuffer();
        var i = 0;
        input = safeStrings(input);
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
            parser.input = uis;
            parser.parse();
        } catch (e) {
            if (uis == null and reload < 2) {
                //automaticky reload ak zlyha pripojenie

                scene.messagePanel.label.content = ##"Connection Error";
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

    /**
    * zmeni specialne znaky aby nerobili problemy v URL
    * input: String[] - vstupne pole retazcov
    * return String[]
    */
    public function safeStrings(input: DataElement[]): DataElement[] {
        for (val in input) {
            val.value.replace({" ";"&"; "?"; "%"; "="; "'"; '"'; '\\'}, {"%20";"%26";"%3F";"%25";"%3D";"%27";"%22";"%5C"});
        }
        return input;
    }

    public function getValueByKey(key: String): String {
        for (a in values) {
            if (a.key == key) {return a.value;}
        }
        return null;
    }

}
