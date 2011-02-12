/*
 * ExpoText.fx
 *
 * Created on 23.3.2010, 22:42:56
 */

package net.ra100.cyd.UI;

import javafx.data.pull.PullParser;
import javafx.data.pull.Event;
import net.ra100.cyd.scene.Helper;

/**
 * @author ra100
 */

public class ExpoText {

    public var title: String;
    public var content: String;

    var url : String;

    var parser = PullParser {
        documentType: PullParser.XML;
        onEvent: function(event: Event) {
            if (event.type == PullParser.END_ELEMENT) {
                if (event.qname.name == "title") {
                    title = event.text;
                } else if (event.qname.name == "content") {
                    content = event.text;
                    content = content.replace('[', '<');
                    content = content.replace(']', '>');
                }
            }
        }
    }

    public function create(name: String, language: String){
        url = "http://ra100.scifi-guide.net/brhlovce/scripts/loadtext.php?name={name}&language={language}";
        parser.input = Helper.urlInputStream(url);
        //httpRequest.start();
        parser.parse();
    }

}
