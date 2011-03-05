package net.ra100.cyd.UI.res;

import javafx.scene.*;
import javafx.scene.image.ImageView;
import javafx.scene.image.Image;
import javafx.scene.transform.Translate;

public class ViewDirection extends CustomNode {
    
   override function create(): Node {
       Group {
           content: [
               ImageView {
                   image: Image {url: "{__DIR__}View.png"}
                   }
           ]
           transforms: Translate { x : -14, y : -24 }
       } // Group
   } // function create()
} // class View


