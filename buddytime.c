/*
 * Buddy's Time plugin v2
 *
 * Copyright (C) 2006, Jon Manning <desplesda@desplesda.net>
 *		   and Alexander Rapp <alexander@alexander.co.tz>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
 * 02111-1307, USA.
 */

#ifndef GAIM_PLUGINS
# define GAIM_PLUGINS
#endif

#include <gdk/gdk.h>
#include <gtk/gtkplug.h>

#include <config.h>
#include <debug.h>
#include <gaim-compat.h>
#include <core.h>
#include <gtkutils.h>
#include <gtkplugin.h>
#include <gtkconv.h>
#include <gtkdialogs.h>
#include <gtkprefs.h>
#include <blist.h>
#include <gtkblist.h>
#include <signals.h>
#include <util.h>
#include <version.h>
#include <internal.h>
#include <gtk/gtkstock.h>
#include <request.h>
#include <gtkgaim-compat.h>
#include <conversation.h>
#include <gtkconvwin.h>
#include <time.h>
#include "plugin.h"


guint timeout_handle; // the handle to the update-time timeout

static char* buddytime_get_localtime(char* buddytimezone) {
	// returns a string containing the adjusted time
  	time_t current_time = time(NULL);
	char* env_tz = getenv("TZ");
	struct tm *buddy_time;
	char *printedtime;

	setenv("TZ",buddytimezone,1);
	buddy_time = localtime(&current_time);
	if (env_tz) { 
		setenv("TZ",env_tz,1); 
	} else {
		unsetenv("TZ");
	}

	printedtime = malloc(32);
	strftime (printedtime, 32, "%H:%M", buddy_time);
	return printedtime;
}
  

static void
buddytime_add_time(GaimConversation *conv)
{
	GaimGtkConversation *gtkconv = GAIM_GTK_CONVERSATION(conv);
	GaimGtkWindow *convwin = gaim_gtkconv_get_window(gtkconv);
	GtkWidget* remote_time;
	
	if (g_hash_table_lookup(conv->data, "buddytime-indicator")) {
		// the widget's already in this conversation! don't add a new one
		return;
	}

	remote_time = gtk_menu_item_new_with_label ("");
	//gtk_widget_set_sensitive(remote_time, FALSE);
	

	if(remote_time) {
		gaim_debug(GAIM_DEBUG_MISC, "buddytime", "Adding remote clock.\n");
		gtk_menu_item_set_right_justified(
				GTK_MENU_ITEM(remote_time), TRUE);
		gtk_widget_show_all(remote_time);
		gtk_menu_shell_append(GTK_MENU_SHELL(convwin->menu.menubar),
				remote_time);
		g_hash_table_insert(conv->data, g_strdup("buddytime-indicator"), remote_time);
	}
}

static void
buddytime_remove_time(GaimConversation *conv)
{
	GtkWidget* time_widget;

	gaim_debug(GAIM_DEBUG_MISC, "buddytime", "Removing remote clock.\n");   
	if (time_widget = g_hash_table_lookup(conv->data, "buddytime-indicator")) {
		gtk_widget_destroy(time_widget);
		//free(time_widget);
	
		// throw this in in case the conversation window isn't actually closing
		// and it's just the plugin being unloaded
		g_hash_table_remove(conv->data, "buddytime-indicator");
	}
}

static void buddytime_remove_time_from_window(GaimGtkWindow* window, gpointer data) {
	gaim_debug(GAIM_DEBUG_MISC, "buddytime", "Removing clock from window %p\n", window);
	buddytime_remove_time(gaim_gtk_conv_window_get_active_conversation(window));
}

static void buddytime_newconv_cb(GaimConversation *conv, gpointer data) {
	GaimGtkConversation *gtkconv = GAIM_GTK_CONVERSATION(conv);
	GaimGtkWindow *convwin = gaim_gtkconv_get_window(gtkconv);
	gaim_debug(GAIM_DEBUG_MISC, "buddytime", "New conversation\n");

	if ((conv != NULL) && (gaim_conversation_get_type(conv) == GAIM_CONV_TYPE_IM )) {
		gaim_debug(GAIM_DEBUG_MISC, "buddytime", "Adding remote clock.\n");
		buddytime_remove_time_from_window(convwin, NULL);
		buddytime_add_time(conv);
	} else {
		gaim_debug(GAIM_DEBUG_ERROR, "buddytime", "New conversation IS NULL\n");
	}
}

static void buddytime_update_clock(GaimConversation* conv) {
	GaimAccount* acct = gaim_conversation_get_account(conv);
	const char* name = gaim_conversation_get_name(conv);
	GaimBuddy* buddy = gaim_find_buddy(acct, name);
	GaimBlistNode* node = &(buddy->node);
	char* remote_timezone = gaim_blist_node_get_string (node, "timezone");
	GtkWidget* time_widget;
	GtkWidget* time_label;
	char* theirtime;

	//gaim_debug(GAIM_DEBUG_MISC, "buddytime", "Updating conversation, this one is with %s\n",
		//name);
	//gaim_debug(GAIM_DEBUG_MISC, "buddytime", "This buddy's timezone is %s\n",
		//remote_timezone);

	if (remote_timezone == NULL) {
		// This buddy has no setting!
		// just return, the label should remain blank
		return;
	}

	time_widget = g_hash_table_lookup(conv->data, "buddytime-indicator");
                                             
	if (time_widget == NULL) {
	  	// whoa, no widget here, maybe the plugin got loaded after the window was created
	  	// create the widget and re-get it
  		buddytime_newconv_cb(conv, NULL);
		time_widget = g_hash_table_lookup(conv->data, "buddytime-indicator");
	} 
  	
	time_label = gtk_bin_get_child(GTK_BIN(time_widget));
	
	theirtime = buddytime_get_localtime(remote_timezone);

	if (theirtime == NULL) {
		gtk_label_set_text(GTK_LABEL (time_label), "");
	} else {	
  	// Print it in nice grey
  	char *markup;
  	markup = g_markup_printf_escaped ("<span foreground=\"gray\"><b>%s</b></span>", theirtime);
  	gtk_label_set_markup (GTK_LABEL (time_label), markup);
  	g_free (markup);
  	g_free (theirtime);
	}
} 

static void buddytime_update_conversation_from_window(GaimGtkWindow* window, gpointer data) {
	//gaim_debug(GAIM_DEBUG_MISC, "buddytime", "Updating window %p\n", window);
	buddytime_update_clock(gaim_gtk_conv_window_get_active_conversation(window));	
}

static void buddytime_update_all_clocks(void) {
	// update all the conversation windows
	GList* window_list;
	GTimeVal current_time;
	g_get_current_time(&current_time);
	
	//gaim_debug(GAIM_DEBUG_MISC, "buddytime", "Updating all clocks (time is %i secs)\n", current_time.tv_sec);
	window_list = gaim_gtk_conv_windows_get_list();
	g_list_foreach(window_list, (GFunc)buddytime_update_conversation_from_window, NULL);
}

gboolean buddytime_update_time_cb(gpointer data1, gpointer data2) {
	buddytime_update_all_clocks();
	return TRUE;
}

gboolean buddytime_switch_conv_cb(GaimConversation *conv) {

	gaim_debug(GAIM_DEBUG_MISC, "buddytime", "Switching conversation\n");
	// fix the time for the new clock
	// buddytime_update_clock(conv);
	
	// hide the old widget and display the new
	buddytime_remove_time(conv);
	buddytime_add_time(conv);
	
	return TRUE;
}

void buddytime_setzone_cb(GaimBlistNode* node, const char* timezone) {
	// set the timezone for the selected blist node
	//gaim_debug(GAIM_DEBUG_MISC, "buddytime", "Setting timezone for %p to %s\n", node, timezone);   
	gaim_blist_node_set_string (node, "timezone", timezone);
	
	// Update the buddy's time immediately
	buddytime_update_all_clocks();

}

void buddytime_setzone_dialog(GaimBlistNode* node, void* data) {
	const char* current_timezone = gaim_blist_node_get_string(node, "timezone");
	gaim_request_input(NULL, _("Set Buddy's Timezone"), NULL,
					   _("Please enter the timezone "
					   "of this buddy in the Unix Area/City "
					   "(e.g. America/New_York) format."), current_timezone, FALSE, FALSE, NULL,
					   _("Set Timezone"), G_CALLBACK(buddytime_setzone_cb),
					   _("Cancel"), NULL, NULL, NULL, NULL, node);
}

void buddytime_menu_cb(GaimBlistNode* node, GList **menu, void* data) {
	GaimMenuAction *action;

	action = gaim_menu_action_new(_("Set Timezone"), G_CALLBACK(buddytime_setzone_dialog), NULL, NULL);
   
	*menu = g_list_append(*menu, action);
}

static gboolean
plugin_load(GaimPlugin *plugin)
{
	gaim_debug(GAIM_DEBUG_INFO, "buddytime", "buddytime plugin loaded.\n");
	gaim_signal_connect(gaim_blist_get_handle(), "blist-node-extended-menu", plugin,
                       GAIM_CALLBACK(buddytime_menu_cb), NULL);
	gaim_signal_connect(gaim_conversations_get_handle(), "conversation-created", plugin,
                       GAIM_CALLBACK(buddytime_newconv_cb), NULL);
	gaim_signal_connect(gaim_conversations_get_handle(), "conversation-switched", plugin,
											 GAIM_CALLBACK(buddytime_switch_conv_cb), NULL);
	gaim_signal_connect(gaim_conversations_get_handle(), "deleting-conversation", plugin,
											 GAIM_CALLBACK(buddytime_remove_time), NULL);

	// update the time every second or so										 
	timeout_handle = g_timeout_add(1000, (GSourceFunc)buddytime_update_time_cb, NULL);
	
	// and update any open windows now
	buddytime_update_all_clocks();
	
	return TRUE;
}

static gboolean
plugin_unload(GaimPlugin *plugin)
{
	// disconnect, unhook and destroy everything
	gaim_signal_disconnect(gaim_blist_get_handle(), "blist-node-extended-menu", plugin,
                          GAIM_CALLBACK(buddytime_menu_cb));
	gaim_signal_disconnect(gaim_conversations_get_handle(), "conversation-created", plugin,
  												GAIM_CALLBACK(buddytime_newconv_cb));
	gaim_signal_disconnect(gaim_conversations_get_handle(), "conversation-switched", plugin,
  												GAIM_CALLBACK(buddytime_switch_conv_cb));
	gaim_signal_disconnect(gaim_conversations_get_handle(), "deleting-conversation", plugin,
  												GAIM_CALLBACK(buddytime_remove_time));
  
	gaim_debug(GAIM_DEBUG_INFO, "buddytime", "buddytime plugin unloaded.\n");


	g_source_remove(timeout_handle);
	
	// remove the clocks from all windows
	GList* window_list;
	window_list = gaim_gtk_conv_windows_get_list();
	g_list_foreach(window_list, (GFunc)buddytime_remove_time_from_window, NULL);

	return TRUE;
}

static GaimPluginInfo info =
{
	GAIM_PLUGIN_MAGIC,
	GAIM_MAJOR_VERSION,
	GAIM_MINOR_VERSION,
	GAIM_PLUGIN_STANDARD,                             /**< type           */
	NULL,                                             /**< ui_requirement */
	0,                                                /**< flags          */
	NULL,                                             /**< dependencies   */
	GAIM_PRIORITY_DEFAULT,                            /**< priority       */

	"gtk-buddytime",                                  /**< id             */
	"Buddy's Time",                                   /**< name           */
	VERSION,                                          /**< version        */
	"Keeps track of your contact's local time",       /**  summary        */
	"This plugin puts a small clock in your conversation window, showing you the local time of "
	"whomever you're talking to.",                    /**  description    */
	"Jon Manning <desplesda@desplesda.net> and Alexander Rapp <alexander@alexander.co.tz>",
                                                          /**< author         */
	PURPLE_WEBSITE,                                   /**< homepage       */

	plugin_load,                                      /**< load           */
	plugin_unload,                                    /**< unload         */
	NULL,                                             /**< destroy        */

	NULL,                                             /**< ui_info        */
	NULL,                                             /**< extra_info     */
	NULL,
	NULL
};

static void
init_plugin(GaimPlugin *plugin)
{
}

GAIM_INIT_PLUGIN(buddytime, init_plugin, info)
