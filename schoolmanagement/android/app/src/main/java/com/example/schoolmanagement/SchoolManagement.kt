package com.example.schoolmanagement

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import android.content.Intent
import android.net.Uri
import android.widget.RemoteViewsService
import android.widget.ArrayAdapter 
import android.widget.ListView

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
    
                    // Update UI efficiently
                    views.setTextViewText(R.id.headline_title, list_titles[0])
    
                    // Update the widget
                    appWidgetManager.updateAppWidget(appWidgetId, views)
                }

                if(list_titles_string.isNullOrEmpty()) {
                    val views = RemoteViews(context.packageName, R.layout.school_management)
                    views.setTextViewText(R.id.headline_title, "No Assignments")
                    appWidgetManager.updateAppWidget(appWidgetId, views)
                }
        }
        // for (appWidgetId in appWidgetIds) {
        //     // updateAppWidget(context, appWidgetManager, appWidgetId)
        //     val arrayAdapter: ArrayAdapter<*> 
        //     val widgetData = HomeWidgetPlugin.getData(context)
        //     val views = RemoteViews(context.packageName, R.layout.school_management)

        //     val list_titles_string = widgetData.getString("assignments", null)
        //     val list_titles = list_titles_string?.split("/?") ?: listOf<String>()

        //     views.setTextViewText(R.id.headline_title, list_titles[0])



        //     appWidgetManager.updateAppWidget(appWidgetId, views)
        // }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
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