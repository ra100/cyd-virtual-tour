package net.ra100.cyd.UI;

import java.util.ArrayList;

/**
 *
 * @author ra100
 */
public class GuestBookList {
    public ArrayList<GuestBook> list;
    public int count;
    public GuestBook items[];

    public GuestBookList(){
        count = 0;
        list = new ArrayList<GuestBook>();
    }

    public void addItem(GuestBook gb){
        list.add(gb);
    }

    public void reset(){
        list = new ArrayList<GuestBook>();
    }

    public ArrayList<GuestBook> getList(){
        return list;
    }

    public void setCount(String c){
        count = Integer.parseInt(c);
    }

    public GuestBook[] getItems(){
        items = new GuestBook[list.size()];
        for (int i = 0; i < list.size(); i++){
            items[i] = list.get(i);
        }
        return items;
    }
}
