package net.ra100.cyd.utils;

import java.util.ArrayList;

/**
 * zoznam prispevkov v knihe navstev
 * @author ra100
 */
public class GuestBookList {
    /**
     * zoznam prispevkov
     */
    public ArrayList<GuestBook> list;

    /**
     * pocet prispevkov
     */
    public int count;

    /**
     * pole s priepevkami pre FX triedy
     */
    public GuestBook items[];

    /**
     * constructor
     */
    public GuestBookList(){
        count = 0;
        list = new ArrayList<GuestBook>();
    }

    /**
     * prida polozku do zoznamu
     * @param gb
     */
    public void addItem(GuestBook gb){
        list.add(gb);
    }

    /**
     * zresetovanie zoznamu
     */
    public void reset(){
        list = new ArrayList<GuestBook>();
    }

    /**
     * getter
     * @return
     */
    public ArrayList<GuestBook> getList(){
        return list;
    }

    /**
     * nastavi pocet prispevkov
     * @param c
     */
    public void setCount(String c){
        count = Integer.parseInt(c);
    }

    /**
     * vrati pole s prispevkami
     * @return
     */
    public GuestBook[] getItems(){
        items = new GuestBook[list.size()];
        for (int i = 0; i < list.size(); i++){
            items[i] = list.get(i);
        }
        return items;
    }
}
