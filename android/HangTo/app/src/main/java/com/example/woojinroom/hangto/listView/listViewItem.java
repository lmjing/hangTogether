package com.example.woojinroom.hangto.listView;

/**
 * Created by woojinroom on 2017-09-25.
 */

import android.graphics.drawable.Drawable;

public class listViewItem {
    private Drawable iconDrawable ;
    private String idStr ;
    private String contentStr ;
    private String timeStr;

    public Drawable getIconDrawable() {
        return iconDrawable;
    }

    public void setIconDrawable(Drawable iconDrawable) {
        this.iconDrawable = iconDrawable;
    }

    public String getIdStr() {
        return idStr;
    }

    public void setIdStr(String idStr) {
        this.idStr = idStr;
    }

    public String getContentStr() {
        return contentStr;
    }

    public void setContentStr(String contentStr) {
        this.contentStr = contentStr;
    }

    public String getTimeStr() {
        return timeStr;
    }

    public void setTimeStr(String timeStr) {
        this.timeStr = timeStr;
    }
}
