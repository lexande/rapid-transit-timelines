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

#ifdef HAVE_CONFIG_H
# include <config.h>
#endif

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

gboolean buddytime_receive_message_cb(GaimAccount *account, char **sender,
                              char **message, GaimConversation *conv)
{
  /* 
  gaim_debug(GAIM_DEBUG_MISC, "buddytime", "Received message: %s\n", *message);
  */
  return FALSE;
}   

gboolean buddytime_request_time_cb(GaimAccount *account, GaimConversation *conv, char **message)
{
  // we request the time if we have no setting for this buddy
  // this function is called when a message is sent
  
  // we need to add a 'hidden' message to the remote buddytime
  // for this we go '<a href="Buddytime"></a>'
  // hopefully this won't show up in too many protocols
  
  /*
  GString* new_message = g_string_new("<a href='Buddytime v1.0::gettime'></a> ");
  g_string_append(new_message, *message);
  
  free(*message);
  *message = g_string_free(new_message, FALSE);
  
  gaim_debug(GAIM_DEBUG_MISC, "buddytime", "Sending message: %s\n", *message);
  */
  return FALSE;
}

char* buddytime_get_localtime(char* buddytimezone) {
  // returns a string containing the adjusted time
  	
  	time_t current_time = time(NULL);
	char * env_tz = getenv("TZ");
	setenv("TZ",buddytimezone,1);
  	struct tm *buddy_time = localtime(&current_time);
	if (env_tz) { setenv("TZ",env_tz,1); } else { unsetenv("TZ"); }

  	char *printedtime = malloc(32);
  	strftime (printedtime, 32, "%H:%M", buddy_time);
  	return printedtime;

}
  

static void
buddytime_add_time(GaimConversation *conv)
{
	GaimGtkWindow *convwin;
	GaimConvIm *im = NULL;
	GaimGtkConversation *gtkconv = GAIM_GTK_CONVERSATION(conv);
	GtkWidget* remote_time;
	
	convwin = gaim_gtkconv_get_window(gtkconv);

	
	if (g_hash_table_lookup(conv->data, "buddytime-indicator")) {
		// the widget's already in this conversation! don't add a new one
		return;
	}

	if(gaim_conversation_get_type(conv) == GAIM_CONV_TYPE_IM)
		im = gaim_conversation_get_im_data(conv);

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
	gaim_debug(GAIM_DEBUG_MISC, "buddytime", "Removing remote clock.\n");   

	GtkWidget* time_widget = g_hash_table_lookup(conv->data, "buddytime-indicator");
	gtk_widget_destroy(time_widget);
	//free(time_widget);
	
	// throw this in in case the conversation window isn't actually closing
	// and it's just the plugin being unloaded
	g_hash_table_remove(conv->data, "buddytime-indicator");
}

static void buddytime_remove_time_from_window(GaimGtkWindow* window, gpointer data) {
	gaim_debug(GAIM_DEBUG_MISC, "buddytime", "Removing clock from window %p\n", window);
	buddytime_remove_time(gaim_gtk_conv_window_get_active_conversation(window));
}

static void buddytime_newconv_cb(GaimConversation *conv, gpointer data) {
  gaim_debug(GAIM_DEBUG_MISC, "buddytime", "New conversation\n");
  GaimGtkWindow *convwin;
  GaimGtkConversation *gtkconv = GAIM_GTK_CONVERSATION(conv);
  convwin = gaim_gtkconv_get_window(gtkconv);

  if ((conv != NULL) && (gaim_conversation_get_type(conv) == GAIM_CONV_TYPE_IM )) {
		gaim_debug(GAIM_DEBUG_MISC, "buddytime", "Adding remote clock.\n");
		buddytime_remove_time_from_window(convwin, NULL);
		buddytime_add_time(conv);
  } else {
    gaim_debug(GAIM_DEBUG_ERROR, "buddytime", "New conversation IS NULL\n");
  }
}

static void buddytime_update_clock(GaimConversation* conv) {
	GaimBuddy* buddy;
	GaimGtkWindow *convwin;
	GaimGtkConversation *gtkconv = GAIM_GTK_CONVERSATION(conv);
	convwin = gaim_gtkconv_get_window(gtkconv);

	GaimAccount* acct = gaim_conversation_get_account(conv);
	const char *name = gaim_conversation_get_name(conv);

	buddy = gaim_find_buddy(acct, name);
	GaimBlistNode* node = &(buddy->node);
	//gaim_debug(GAIM_DEBUG_MISC, "buddytime", "Updating conversation, this one is with %s\n",
		//name);
	//gaim_debug(GAIM_DEBUG_MISC, "buddytime", "This buddy's timezone is %s\n",
		//gaim_blist_node_get_string (node, "timezone"));
	
	const char* tz_setting = gaim_blist_node_get_string (node, "timezone");
	
	char * remote_timezone_hrs;  
	if (tz_setting == NULL) {
		// This buddy has no setting!
		// just return, the label should remain blank
		return;
	}	else {
		remote_timezone_hrs = tz_setting;
	}

  GtkWidget* time_widget = g_hash_table_lookup(conv->data, "buddytime-indicator");
                                             
  if (time_widget == NULL) {
  	// whoa, no widget here, maybe the plugin got loaded after the window was created
  	// create the widget and re-get it
  	buddytime_newconv_cb(conv, NULL);
		time_widget = g_hash_table_lookup(conv->data, "buddytime-indicator");
	} 
  	
	GtkWidget* time_label = gtk_bin_get_child(GTK_BIN(time_widget));
	
  char* theirtime = buddytime_get_localtime(remote_timezone_hrs);

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
	buddytime_remove_time_from_window(window, NULL);
	buddytime_update_clock(gaim_gtk_conv_window_get_active_conversation(window));	
}

void buddytime_update_all_clocks(void) {
	// update all the conversation windows
	GList* window_list;
	GList* conv_list;
	GTimeVal current_time;
	g_get_current_time(&current_time);
	
	//gaim_debug(GAIM_DEBUG_MISC, "buddytime", "Updating all clocks (time is %i secs)\n", current_time.tv_sec);
	
	conv_list = gaim_get_conversations();
	window_list = gaim_gtk_conv_windows_get_list();
	g_list_foreach(conv_list, (GFunc)buddytime_remove_time, NULL);
	g_list_foreach(window_list, (GFunc)buddytime_update_conversation_from_window, NULL);
}

gboolean buddytime_update_time_cb(gpointer data1, gpointer data2) {
	buddytime_update_all_clocks();
	return TRUE;
}

gboolean buddytime_switch_conv_cb(GaimConversation *oldconv, GaimConversation *newconv) {

	gaim_debug(GAIM_DEBUG_MISC, "buddytime", "Switching from %s to %s\n", oldconv->name, newconv->name);
	// fix the time for the new clock
	buddytime_update_clock(newconv);
	
	// hide the old widget and display the new
	buddytime_remove_time(oldconv);
	buddytime_add_time(newconv);
	
	return TRUE;
}

/* static void buddytime_hide_clock(GaimConversation *conv, gpointer data) {
	gtk_widget_hide_all(g_hash_table_lookup(conv->data, "buddytime-indicator"));
}

static void buddytime_hide_all_clocks(gpointer data1, gpointer data2) {
	GList* window_list;

	window_list = gaim_get_conversations();
	g_list_foreach(window_list, buddytime_hide_clock, NULL);
	return TRUE;
} */
	

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

void buddytime_tooltip_cb(GaimBlistNode *node, char **text) {
  // append both their local time
  const char* tz_setting = gaim_blist_node_get_string (node, "timezone");
	
	char * remote_timezone_hrs;  
	if (tz_setting == NULL) {
		// This buddy has no setting!
  	return;
	}	else {
		remote_timezone_hrs = tz_setting;
	}
	
  GString* new_tip = g_string_new(*text);
  free(*text);
  char* t = buddytime_get_localtime(remote_timezone_hrs);
  if (t == NULL)
    return;
  new_tip = g_string_append(new_tip, t);
  *text = g_string_free(new_tip, FALSE);
}

static gboolean
plugin_load(GaimPlugin *plugin)
{
	gaim_debug(GAIM_DEBUG_INFO, "buddytime", "buddytime plugin loaded.\n");
	gaim_signal_connect(gaim_blist_get_handle(), "blist-node-extended-menu", plugin,
                       GAIM_CALLBACK(buddytime_menu_cb), NULL);
	gaim_signal_connect(gaim_conversations_get_handle(), "conversation-created", plugin,
                       GAIM_CALLBACK(buddytime_newconv_cb), NULL);
	gaim_signal_connect(gaim_conversations_get_handle(), "conversation-switching", plugin,
											 GAIM_CALLBACK(buddytime_switch_conv_cb), NULL);
	gaim_signal_connect(gaim_conversations_get_handle(), "deleting-conversation", plugin,
											 GAIM_CALLBACK(buddytime_remove_time), NULL);
	gaim_signal_connect(gaim_conversations_get_handle(), "receiving-im-msg", plugin, 
                       GAIM_CALLBACK(buddytime_receive_message_cb), NULL);
	gaim_signal_connect(gaim_conversations_get_handle(), "writing-im-msg", plugin, 
                       GAIM_CALLBACK(buddytime_request_time_cb), NULL);
											 
	gaim_signal_connect(gaim_blist_get_handle(), "drawing-tooltip", plugin, 
                       GAIM_CALLBACK(buddytime_tooltip_cb), NULL);

	// update the time every minute or so										 
	timeout_handle = g_timeout_add(500, (GSourceFunc)buddytime_update_time_cb, NULL);
	
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
  gaim_signal_disconnect(gaim_conversations_get_handle(), "conversation-switching", plugin,
  												GAIM_CALLBACK(buddytime_switch_conv_cb));
  gaim_signal_disconnect(gaim_conversations_get_handle(), "deleting-conversation", plugin,
  												GAIM_CALLBACK(buddytime_remove_time));
  gaim_signal_disconnect(gaim_conversations_get_handle(), "receiving-im-msg", plugin, 
                          GAIM_CALLBACK(buddytime_receive_message_cb)); 
	gaim_signal_disconnect(gaim_conversations_get_handle(), "writing-im-msg", plugin, 
                       GAIM_CALLBACK(buddytime_request_time_cb));
  
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

	"gtk-buddytime",                                /**< id             */
	"Buddy's Time",                           /**< name           */
	VERSION,                                          /**< version        */
	                                                  /**  summary        */
	"Keeps track of your contact's local time",
	                                                  /**  description    */
	"This plugin puts a small clock in your conversation window, showing you the local time of "
	"whomever you're talking to.",
	"Jon Manning <desplesda@desplesda.net> and Alexander Rapp <alexander@alexander.co.tz>",      /**< author         */
	PURPLE_WEBSITE,                                          /**< homepage       */

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
