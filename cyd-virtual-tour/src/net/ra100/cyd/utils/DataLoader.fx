package net.ra100.cyd.utils;

import javafx.data.pull.PullParser;
import javafx.data.pull.Event;
import net.ra100.cyd.main.PanoScene;
import java.lang.StringBuffer;

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
    public var input: String[];

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

    public function create(){
        var language = scene.language;
        var id = scene.id;
        var token = scene.token;
        var vals: StringBuffer = new StringBuffer();
        var i = 0;
        for (val in input) {
            i++;
            val.replace({" ";"&"; "?"; "%"; "="; "'"; '"'; '\\'}, {"%20";"%26";"%3F";"%25";"%3D";"%27";"%22";"%5C"});
            vals.append("&value{i}={val}")  
        }
        vals.append("&count={i}");

        url = "{baseURL}?action={action}&language={language}&id={id}&token={token}{vals.toString()}";

        var uis = Helper.urlInputStream(url);
        if (uis == null) {
            // TODO chybova hlaska
            // vyskoci okno, moznost refresh
        } else {
            parser.input = uis;
            parser.parse();
        }
    }
}
