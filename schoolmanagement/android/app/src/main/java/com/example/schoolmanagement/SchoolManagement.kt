package com.example.schoolmanagement

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin




/**
 * Implementation of App Widget functionality.
 */
class SchoolManagement : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            // Fetch data asynchronously
                val widgetData = HomeWidgetPlugin.getData(context)
                val list_titles_string = widgetData.getString("assignments", null)
    
                // Avoid unnecessary operations
                if (!list_titles_string.isNullOrEmpty()) {
                    val list_titles = list_titles_string.split("/?")
                    val views = RemoteViews(context.packageName, R.layout.school_management)

                    for (i in 0 until list_titles.size) {
                        var visible = true
                        if(list_titles[i].isNullOrEmpty()){
                            visible =false
                        }

                        if(visible){
                            val titleViewId = context.resources.getIdentifier("assignment_title_$i", "id", context.packageName)
                            val dateViewId = context.resources.getIdentifier("assignment_due_date_$i", "id", context.packageName)
                            views.setTextViewText(titleViewId, "${i+1}. ${list_titles[i]}")
                            views.setTextViewText(dateViewId, "Due Date!!!")
                            views.setViewVisibility(titleViewId, View.VISIBLE)
                            views.setViewVisibility(dateViewId, View.VISIBLE)
                        }
                    }
                    
    
                    // Update the widget
                    appWidgetManager.updateAppWidget(appWidgetId, views)
                }

                if(list_titles_string.isNullOrEmpty()) {
                    val views = RemoteViews(context.packageName, R.layout.school_management)
                    views.setViewVisibility(R.id.no_assignment_text, View.VISIBLE)

                    //for the linear Layout
                    appWidgetManager.updateAppWidget(appWidgetId, views)
                }
        }
    }
}

internal fun updateAppWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int
) {
    val widgetText = context.getString(R.string.appwidget_text)
    // Construct the RemoteViews object
    val views = RemoteViews(context.packageName, R.layout.school_management)
    views.setTextViewText(R.id.widget_container, widgetText)

    // Instruct the widget manager to update the widget
    appWidgetManager.updateAppWidget(appWidgetId, views)
}