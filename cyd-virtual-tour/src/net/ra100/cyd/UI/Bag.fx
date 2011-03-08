/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package net.ra100.cyd.UI;

import javafx.scene.CustomNode;
import javafx.scene.Node;
import net.ra100.cyd.main.PanoScene;
import javafx.scene.layout.Tile;

/**
 * @author Rastislav R@100 Švarba
 */

public class Bag extends CustomNode {

    public var myScene: PanoScene;

    public var items: Item[];

    public var bag: Tile = Tile {
        hgap: 5
        vgap: 5
        columns: 5
        rows: 2
        content: bind items
    };

    public override function create(): Node {
        return bag;
    }

    public function addItem(it: Item): Void {
        for (i in items) {
            if (i.type == it.type) { i.take(it.itemid); return;}
        }
        it.take(it.itemid);
        insert it into items;
    }

    public function removeItem(it: Item): Void {
        delete it from items;
    }

    /**
    get by ID
    */
    public function getItem(num: Integer): Item {
        for (it in items) {
            if (it.itemid == num) return it;
        }
        return null;
    }

}
