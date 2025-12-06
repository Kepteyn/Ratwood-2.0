/datum/preferences/proc/open_vices_menu(mob/user)
	if(!user || !user.client)
		return
	
	user << browse(generate_vices_html(user), "window=character_custom;size=1200x800")

/datum/preferences/proc/get_theme_colors()
	var/list/colors = list()
	
	switch(tgui_theme)
		if("azure_default")
			colors["bg"] = "#000000"
			colors["text"] = "#897472"
			colors["label"] = "#897472"
			colors["border"] = "#7b5353"
			colors["panel"] = "#511111"
			colors["panel_dark"] = "rgba(81, 17, 17, 0.6)"
			colors["button_hover"] = "rgba(123, 83, 83, 0.3)"
			colors["accent"] = "#ae3636"
		if("azure_green")
			colors["bg"] = "#141b15"
			colors["text"] = "#d0d4cc"
			colors["label"] = "#d0d4cc"
			colors["border"] = "#619940"
			colors["panel"] = "#343f35"
			colors["panel_dark"] = "rgba(52, 63, 53, 0.6)"
			colors["button_hover"] = "rgba(97, 153, 64, 0.3)"
			colors["accent"] = "#619940"
		if("azure_purple")
			colors["bg"] = "#1a0f1f"
			colors["text"] = "#d4c8e0"
			colors["label"] = "#d4c8e0"
			colors["border"] = "#8b5fa8"
			colors["panel"] = "#3d2850"
			colors["panel_dark"] = "rgba(61, 40, 80, 0.6)"
			colors["button_hover"] = "rgba(139, 95, 168, 0.3)"
			colors["accent"] = "#8b5fa8"
		if("azure_lane")
			colors["bg"] = "#0f1419"
			colors["text"] = "#c8d4e0"
			colors["label"] = "#c8d4e0"
			colors["border"] = "#5f8ba8"
			colors["panel"] = "#283d50"
			colors["panel_dark"] = "rgba(40, 61, 80, 0.6)"
			colors["button_hover"] = "rgba(95, 139, 168, 0.3)"
			colors["accent"] = "#5f8ba8"
		else // trey_liam or default
			colors["bg"] = "#1C0000"
			colors["text"] = "#e3c06f"
			colors["label"] = "#999"
			colors["border"] = "#444"
			colors["panel"] = "rgba(0, 0, 0, 0.6)"
			colors["panel_dark"] = "rgba(0, 0, 0, 0.4)"
			colors["button_hover"] = "rgba(227, 192, 111, 0.2)"
			colors["accent"] = "#e3c06f"
	
	return colors

/datum/preferences/proc/generate_vices_html(mob/user)
	var/list/theme = get_theme_colors()
	
	var/html = {"
		<!DOCTYPE html>
		<html lang="en">
		<meta charset='UTF-8'>
		<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'/>
		<style>
			body {
				font-family: Verdana, Arial, sans-serif;
				background: [theme["bg"]];
				color: [theme["text"]];
				margin: 0;
				padding: 0;
			}
			.header {
				text-align: center;
				padding: 15px;
				background: [theme["panel_dark"]];
				border-bottom: 2px solid [theme["border"]];
			}
			.header h1 {
				margin: 0;
				color: [theme["text"]];
				font-size: 1.8em;
			}
			.header p {
				margin: 5px 0;
				font-size: 0.9em;
				color: [theme["label"]];
			}
			.tabs {
				display: flex;
				background: [theme["panel"]];
				border-bottom: 1px solid [theme["border"]];
				padding: 0;
				margin: 0;
			}
			.tab {
				flex: 1;
				padding: 15px 20px;
				text-align: center;
				background: [theme["panel_dark"]];
				border-right: 1px solid [theme["border"]];
				color: [theme["label"]];
				cursor: pointer;
				text-decoration: none;
				display: block;
			}
			.tab:hover {
				background: [theme["button_hover"]];
				color: [theme["text"]];
			}
			.tab.active {
				background: [theme["button_hover"]];
				color: [theme["text"]];
				border-bottom: 3px solid [theme["accent"]];
			}
			.tab-content {
				padding: 20px;
				display: none;
			}
			.tab-content.active {
				display: block;
			}
			.vices-grid {
				display: grid;
				grid-template-columns: repeat(1, 1fr);
				gap: 15px;
			}
			.vice-slot {
				background: [theme["panel_dark"]];
				border: 1px solid [theme["border"]];
				padding: 15px;
			}
			.vice-slot.required {
				border-color: [theme["accent"]];
			}
			.vice-slot:hover {
				border-color: [theme["accent"]];
			}
			.slot-header {
				display: flex;
				justify-content: space-between;
				align-items: center;
				margin-bottom: 10px;
				padding-bottom: 10px;
				border-bottom: 1px solid [theme["border"]];
			}
			.slot-number {
				font-weight: bold;
				color: [theme["text"]];
			}
			.slot-required {
				background: [theme["accent"]];
				color: [theme["bg"]];
				padding: 2px 8px;
				font-size: 0.8em;
				font-weight: bold;
			}
			.slot-cost {
				background: #4CAF50;
				color: #1C0000;
				padding: 2px 8px;
				font-size: 0.9em;
				font-weight: bold;
			}
			.vice-display {
				display: flex;
				align-items: flex-start;
				margin-bottom: 10px;
			}
			.vice-info {
				flex: 1;
			}
			.vice-name {
				font-weight: bold;
				color: [theme["text"]];
				margin-bottom: 5px;
			}
			.vice-desc {
				font-size: 0.85em;
				color: [theme["label"]];
				line-height: 1.4;
			}
			.btn {
				padding: 6px 12px;
				border: 1px solid [theme["border"]];
				background: [theme["panel_dark"]];
				color: [theme["text"]];
				cursor: pointer;
				font-family: Verdana, Arial, sans-serif;
				font-size: 0.85em;
				text-decoration: none;
				display: inline-block;
				margin: 2px;
			}
			.btn:hover {
				background: [theme["button_hover"]];
				border-color: [theme["accent"]];
			}
			.btn-select {
				background: rgba(76, 175, 80, 0.3);
				border-color: #4CAF50;
				color: #4CAF50;
			}
			.btn-select:hover {
				background: rgba(76, 175, 80, 0.5);
			}
			.btn-clear {
				background: rgba(244, 67, 54, 0.3);
				border-color: #f44336;
				color: #f44336;
			}
			.btn-clear:hover {
				background: rgba(244, 67, 54, 0.5);
			}
			.btn-customize {
				background: rgba(33, 150, 243, 0.3);
				border-color: #2196F3;
				color: #2196F3;
			}
			.btn-customize:hover {
				background: rgba(33, 150, 243, 0.5);
			}
			.btn-color {
				background: rgba(156, 39, 176, 0.3);
				border-color: #9C27B0;
				color: #9C27B0;
			}
			.btn-color:hover {
				background: rgba(156, 39, 176, 0.5);
			}
			.empty-slot {
				text-align: center;
				padding: 20px;
				color: [theme["label"]];
				font-style: italic;
			}
			.actions {
				margin-top: 10px;
				display: flex;
				flex-wrap: wrap;
				gap: 5px;
			}
			.statpack-section {
				background: [theme["button_hover"]];
				border: 2px solid [theme["accent"]];
				padding: 20px;
				margin-bottom: 20px;
			}
			.statpack-section h2 {
				margin: 0 0 10px 0;
				color: [theme["text"]];
				font-size: 1.2em;
				border-bottom: 1px solid [theme["border"]];
				padding-bottom: 10px;
			}
			.statpack-current {
				background: [theme["panel_dark"]];
				padding: 15px;
				margin: 10px 0;
				border: 1px solid [theme["border"]];
			}
			.statpack-name {
				font-weight: bold;
				color: [theme["text"]];
				font-size: 1.1em;
				margin-bottom: 8px;
			}
			.statpack-desc {
				color: [theme["label"]];
				line-height: 1.4;
				margin-bottom: 10px;
			}
			.statpack-stats {
				color: #4CAF50;
				font-style: italic;
				font-size: 0.9em;
			}
		</style>
		<script>
			function showTab(tabName) {
				// Hide all tab contents
				var contents = document.getElementsByClassName('tab-content');
				for(var i = 0; i < contents.length; i++) {
					contents\[i\].classList.remove('active');
				}
				
				// Remove active from all tabs
				var tabs = document.getElementsByClassName('tab');
				for(var i = 0; i < tabs.length; i++) {
					tabs\[i\].classList.remove('active');
				}
				
				// Show selected tab content
				document.getElementById(tabName).classList.add('active');
				event.target.classList.add('active');
				
				// Save current tab to cookie
				document.cookie = 'vices_menu_tab=' + tabName + '; path=/';
			}
			
			// Restore active tab on load
			window.onload = function() {
				var cookies = document.cookie.split(';');
				var activeTab = 'traits';
				for(var i = 0; i < cookies.length; i++) {
					var cookie = cookies\[i\].trim();
					if(cookie.indexOf('vices_menu_tab=') == 0) {
						activeTab = cookie.substring('vices_menu_tab='.length);
						break;
					}
				}
				
				// Activate the saved tab
				if(activeTab && document.getElementById(activeTab)) {
					var contents = document.getElementsByClassName('tab-content');
					for(var i = 0; i < contents.length; i++) {
						contents\[i\].classList.remove('active');
					}
					
					var tabs = document.getElementsByClassName('tab');
					for(var i = 0; i < tabs.length; i++) {
						tabs\[i\].classList.remove('active');
						if(tabs\[i\].getAttribute('onclick') && tabs\[i\].getAttribute('onclick').indexOf(activeTab) >= 0) {
							tabs\[i\].classList.add('active');
						}
					}
					
					document.getElementById(activeTab).classList.add('active');
				}
			};
		</script>
		<body>
			<div class="header">
				<h1>⚔ Character Customization ⚔</h1>
				<p>Configure all your character features</p>
			</div>
			
			<div class="tabs">
				<a class="tab active" onclick="showTab('traits')">Traits & Virtues</a>
				<a class="tab" onclick="showTab('loadout')">Loadout Items</a>
				<a class="tab" onclick="showTab('languages')">Languages</a>
			</div>
			
			<div id="traits" class="tab-content active">
			
			<div class="statpack-section">
				<h2>📊 Statpack Selection</h2>
				<div class="statpack-current">
					<div class="statpack-name">[statpack.name]</div>
					<div class="statpack-desc">[statpack.description_string()]</div>
				</div>
				<div class="actions">
					<a class='btn btn-select' href='byond://?src=\ref[src];statpack_action=change'>Change Statpack</a>
				</div>
			</div>
			
		<div class="statpack-section">
			<h2>✨ Virtue Selection</h2>
			<div class="statpack-current">
				<div class="statpack-name">Primary Virtue: [virtue.name]</div>
				<div class="statpack-desc">[virtue.desc]</div>
			</div>"}
	
	if(statpack.name == "Virtuous")
		html += {"
			<div class="statpack-current" style='margin-top: 10px;'>
				<div class="statpack-name">Second Virtue: [virtuetwo.name]</div>
				<div class="statpack-desc">[virtuetwo.desc]</div>
			</div>"}
	
	html += {"
			<div class="actions">
				<a class='btn btn-select' href='byond://?src=\ref[src];virtue_action=change_primary'>Change Primary Virtue</a>"}
	
	if(statpack.name == "Virtuous")
		html += "<a class='btn btn-select' href='byond://?src=\ref[src];virtue_action=change_secondary'>Change Second Virtue</a>"
	
	html += {"
			</div>
		</div>
		
		<h2 style='color: [theme["text"]]; padding: 0 20px; margin: 20px 0 10px 0; border-bottom: 1px solid [theme["border"]]; padding-bottom: 10px;'>⚔ Vice Selection</h2>
		<p style='color: [theme["label"]]; padding: 0 20px; margin: 0 0 15px 0; font-size: 0.9em;'>Select up to 5 vices (at least 1 required). Some vices grant Triumphs but all impose character limitations.</p>			<div class="vices-grid">
	"}
	
	// Generate 5 vice slots
	for(var/i = 1 to 5)
		var/slot_var = "vice[i]"
		var/datum/charflaw/current_vice = vars[slot_var]
		var/is_required = (i == 1)
		
		html += "<div class='vice-slot[is_required ? " required" : ""]'>"
		html += "<div class='slot-header'>"
		html += "<span class='slot-number'>Vice Slot [i]</span>"
		
		if(is_required)
			html += "<span class='slot-required'>REQUIRED</span>"
		
		if(current_vice)
			// Extract triumph value from name
			var/triumph_match = findtext(current_vice.name, "(+")
			if(triumph_match)
				var/triumph_end = findtext(current_vice.name, " TRI)", triumph_match)
				if(triumph_end)
					var/triumph_str = copytext(current_vice.name, triumph_match + 2, triumph_end)
					html += "<span class='slot-cost'>+[triumph_str] Triumphs</span>"
		
		html += "</div>"
		
		if(current_vice)
			// Vice is selected
			html += "<div class='vice-display'>"
			html += "<div class='vice-info'>"
			html += "<div class='vice-name'>[current_vice.name]</div>"
			html += "<div class='vice-desc'>[current_vice.desc]</div>"
			html += "</div>"
			html += "</div>"
			
			html += "<div class='actions'>"
			html += "<a class='btn btn-select' href='byond://?src=\ref[src];vice_action=change;slot=[i]'>Change Vice</a>"
			if(!is_required)
				html += "<a class='btn btn-clear' href='byond://?src=\ref[src];vice_action=clear;slot=[i]'>Clear</a>"
			html += "</div>"
		else
			// Empty slot
			html += "<div class='empty-slot'>"
			if(is_required)
				html += "No Vice Selected - <b>REQUIRED</b><br><br>"
			else
				html += "Empty Slot<br><br>"
			html += "<a class='btn btn-select' href='byond://?src=\ref[src];vice_action=select;slot=[i]'>Select Vice</a>"
			html += "</div>"
		
		html += "</div>"
	
	html += {"
			</div>
			</div>
			
		<div id="loadout" class="tab-content">
			<h2 style='color: [theme["text"]]; margin: 0 0 20px 0;'>⚔ Loadout Selection ⚔</h2>
	"}
	
	// Calculate triumph costs for loadout
	var/total_triumphs = user.get_triumphs() || 0
	var/loadout_spent = 0
	for(var/i = 1 to 10)
		var/datum/loadout_item/loadout_slot = vars["loadout[i == 1 ? "" : "[i]"]"]
		if(loadout_slot && loadout_slot.triumph_cost)
			loadout_spent += loadout_slot.triumph_cost
	
	var/loadout_remaining = total_triumphs - loadout_spent
	
	html += {"
			<div class='statpack-section'>
				<div style='font-size: 1em; margin-bottom: 10px;'>
					<span style='color: #4CAF50;'>Available Triumphs: [loadout_remaining]</span> | 
					<span style='color: [theme["accent"]];'>Spent: [loadout_spent]</span> / 
					<span>Total: [total_triumphs]</span>
				</div>
			</div>
			<div style='display: grid; grid-template-columns: repeat(2, 1fr); gap: 15px;'>
	"}
	
	// Generate loadout slots with original styling
	for(var/i = 1 to 10)
		var/slot_var = i == 1 ? "loadout" : "loadout[i]"
		var/datum/loadout_item/current_item = vars[slot_var]
		var/custom_name = vars["loadout_[i]_name"]
		var/custom_desc = vars["loadout_[i]_desc"]
		var/item_color = vars["loadout_[i]_hex"]
		
		html += "<div class='vice-slot'>"
		html += "<div class='slot-header'>"
		html += "<span class='slot-number'>Slot [i]</span>"
		
		if(current_item && current_item.triumph_cost)
			html += "<span class='slot-cost'>[current_item.triumph_cost] Triumphs</span>"
		
		html += "</div>"
		
		if(current_item)
			// Item is selected - show with icon
			var/obj/item/sample = current_item.path
			var/icon_file = initial(sample.icon)
			var/icon_state = initial(sample.icon_state)
			var/item_desc = initial(sample.desc)
			
			html += "<div style='display: flex; align-items: center; margin-bottom: 10px;'>"
			html += "<div style='width: 64px; height: 64px; background: rgba(0,0,0,0.6); border: 1px solid #444; margin-right: 15px; display: flex; align-items: center; justify-content: center;'>"
			
			// Use the item's icon
			if(icon_file && icon_state)
				user << browse_rsc(icon(icon_file, icon_state), "loadout_icon_[i].png")
				html += "<img src='loadout_icon_[i].png' style='max-width: 60px; max-height: 60px;' />"
			
			html += "</div>"
			html += "<div style='flex: 1;'>"
			html += "<div class='vice-name'>[custom_name ? custom_name : current_item.name]</div>"
			html += "<div class='vice-desc'>[custom_desc ? custom_desc : (item_desc ? item_desc : current_item.desc)]</div>"
			
			if(custom_name || custom_desc)
				html += "<div style='margin-top: 5px; font-size: 0.8em; color: [theme["label"]];'>✎ Customized</div>"
			
			if(item_color)
				html += "<div style='margin-top: 5px; font-size: 0.8em; color: [item_color];'>● Color: [item_color]</div>"
			
			html += "</div>"
			html += "</div>"
			
			html += "<div class='actions'>"
			html += "<a class='btn btn-select' href='byond://?src=\ref[src];loadout_action=change;slot=[i]'>Change Item</a>"
			html += "<a class='btn btn-customize' href='byond://?src=\ref[src];loadout_action=rename;slot=[i]'>Rename</a>"
			html += "<a class='btn btn-customize' href='byond://?src=\ref[src];loadout_action=describe;slot=[i]'>Description</a>"
			html += "<a class='btn btn-color' href='byond://?src=\ref[src];loadout_action=color;slot=[i]'>Color</a>"
			html += "<a class='btn btn-clear' href='byond://?src=\ref[src];loadout_action=clear;slot=[i]'>Clear</a>"
			html += "</div>"
		else
			html += "<div class='empty-slot'>"
			html += "Empty Slot<br><br>"
			html += "<a class='btn btn-select' href='byond://?src=\ref[src];loadout_action=select;slot=[i]'>Select Item</a>"
			html += "</div>"
		
		html += "</div>"
	
	html += {"
			</div>
		</div>
		
		<div id="languages" class="tab-content">
			<h2 style='color: [theme["text"]]; margin: 0 0 20px 0;'>📜 Additional Language Selection 📜</h2>
	"}
	
	// Calculate language costs
	var/lang_spent = 0
	var/purchased_count = 0
	if(extra_language_1 && extra_language_1 != "None")
		purchased_count++
	if(extra_language_2 && extra_language_2 != "None")
		purchased_count++
	
	lang_spent = purchased_count * 2
	var/lang_remaining = total_triumphs - lang_spent
	
	html += {"
			<div class='statpack-section' style='background: rgba(76, 175, 80, 0.1); border: 1px solid #4CAF50; padding: 15px; margin-bottom: 20px;'>
				<p style='margin: 0 0 10px 0;'>ℹ You get <b>one free language</b> based on your character background, plus up to 2 additional triumph languages (2 triumphs each). Your race already grants you certain languages by default.</p>
				<div style='font-size: 1em;'>
					<span style='color: #4CAF50;'>Available Triumphs: [lang_remaining]</span> | 
					<span style='color: [theme["accent"]];'>Spent: [lang_spent]</span> / 
					<span>Total: [total_triumphs]</span>
				</div>
			</div>
			<div style='display: grid; grid-template-columns: repeat(2, 1fr); gap: 15px;'>
	"}
	
	// FREE LANGUAGE SLOT
	var/datum/language/free_lang
	if(ispath(extra_language, /datum/language))
		free_lang = new extra_language()
	
	html += "<div class='vice-slot' style='border-color: #4CAF50;'>"
	html += "<div class='slot-header'>"
	html += "<span class='slot-number'>Free Language</span>"
	html += "<span class='slot-cost' style='background: #4CAF50; color: [theme["bg"]];'>FREE</span>"
	html += "</div>"
	
	if(free_lang)
		html += "<div class='vice-display'>"
		html += "<div class='vice-info'>"
		html += "<div class='vice-name'>[free_lang.name]</div>"
		html += "<div class='vice-desc'>[free_lang.desc]</div>"
		html += "</div>"
		html += "</div>"
		html += "<div class='actions'>"
		html += "<a class='btn btn-select' href='byond://?src=\ref[src];language_action=free_change'>Change Language</a>"
		html += "</div>"
		qdel(free_lang)
	else
		html += "<div class='empty-slot'>"
		html += "No Language Selected<br><br>"
		html += "<a class='btn btn-select' href='byond://?src=\ref[src];language_action=free_select'>Select Language</a>"
		html += "</div>"
	
	html += "</div>"
	
	// Generate 2 TRIUMPH language slots
	for(var/i = 1 to 2)
		var/slot_var = i == 1 ? "extra_language_1" : "extra_language_2"
		var/current_lang_path = vars[slot_var]
		
		html += "<div class='vice-slot'>"
		html += "<div class='slot-header'>"
		html += "<span class='slot-number'>Language Slot [i]</span>"
		
		if(current_lang_path && current_lang_path != "None")
			html += "<span class='slot-cost'>2 Triumphs</span>"
		
		html += "</div>"
		
		if(current_lang_path && current_lang_path != "None")
			// Language is selected
			var/datum/language/lang = new current_lang_path()
			
			html += "<div class='vice-display'>"
			html += "<div class='vice-info'>"
			html += "<div class='vice-name'>[lang.name]</div>"
			html += "<div class='vice-desc'>[lang.desc]</div>"
			html += "</div>"
			html += "</div>"
			
			html += "<div class='actions'>"
			html += "<a class='btn btn-select' href='byond://?src=\ref[src];language_action=change;slot=[i]'>Change Language</a>"
			html += "<a class='btn btn-clear' href='byond://?src=\ref[src];language_action=clear;slot=[i]'>Clear</a>"
			html += "</div>"
			
			qdel(lang)
		else
			html += "<div class='empty-slot'>"
			html += "No Language Selected<br><br>"
			html += "<a class='btn btn-select' href='byond://?src=\ref[src];language_action=select;slot=[i]'>Select Language</a>"
		html += "</div>"
	
	html += "</div>"
	
	html += {"
		</div>
	</body>
	</html>
	"}
	
	return html

/datum/preferences/Topic(href, href_list)
	. = ..()
	
	if(href_list["virtue_action"])
		var/action = href_list["virtue_action"]
		
		switch(action)
			if("change_primary")
				// Build virtue list
				var/list/virtues_available = list()
				for(var/path as anything in GLOB.virtues)
					var/datum/virtue/V = GLOB.virtues[path]
					if(!V.name)
						continue
					// Check if restricted by species
					if(length(pref_species.restricted_virtues))
						if(V.type in pref_species.restricted_virtues)
							continue
					virtues_available[V.name] = V
				
				virtues_available = sort_list(virtues_available)
				var/choice = tgui_input_list(usr, "Choose your primary virtue:", "Virtue Selection", virtues_available)
				
				if(choice)
					var/datum/virtue/selected = virtues_available[choice]
					virtue = selected
					to_chat(usr, span_notice("Selected [choice] as primary virtue."))
					to_chat(usr, "<span class='info'>[selected.desc]</span>")
					save_preferences()
					open_vices_menu(usr)
				return
			
			if("change_secondary")
				if(statpack.name != "Virtuous")
					to_chat(usr, span_warning("Second virtue is only available with the Virtuous statpack!"))
					return
				
				// Build virtue list
				var/list/virtues_available = list()
				for(var/path as anything in GLOB.virtues)
					var/datum/virtue/V = GLOB.virtues[path]
					if(!V.name)
						continue
					// Check if restricted by species
					if(length(pref_species.restricted_virtues))
						if(V.type in pref_species.restricted_virtues)
							continue
					virtues_available[V.name] = V
				
				virtues_available = sort_list(virtues_available)
				var/choice = tgui_input_list(usr, "Choose your second virtue:", "Second Virtue Selection", virtues_available)
				
				if(choice)
					var/datum/virtue/selected = virtues_available[choice]
					virtuetwo = selected
					to_chat(usr, span_notice("Selected [choice] as second virtue."))
					to_chat(usr, "<span class='info'>[selected.desc]</span>")
					save_preferences()
					open_vices_menu(usr)
				return
		return
	
	if(href_list["statpack_action"])
		if(href_list["statpack_action"] == "change")
			// Build statpack list
			var/list/statpacks_available = list()
			for (var/path as anything in GLOB.statpacks)
				var/datum/statpack/SP = GLOB.statpacks[path]
				if (!SP.name)
					continue
				statpacks_available[SP.name] = SP
			
			statpacks_available = sort_list(statpacks_available)
			var/choice = tgui_input_list(usr, "Choose your statpack:", "Statpack Selection", statpacks_available)
			
			if(choice)
				var/datum/statpack/selected = statpacks_available[choice]
				statpack = selected
				to_chat(usr, span_notice("Selected [choice] statpack."))
				to_chat(usr, "<span class='info'>[selected.description_string()]</span>")
				
				// Handle virtuetwo based on statpack
				if(statpack.name == "Virtuous")
					// Keep virtuetwo if we have it
				else
					virtuetwo = GLOB.virtues[/datum/virtue/none]
				
				save_preferences()
				open_vices_menu(usr)
		return
	
	if(href_list["vice_action"])
		var/action = href_list["vice_action"]
		var/slot = text2num(href_list["slot"])
		
		if(!slot || slot < 1 || slot > 5)
			return
		
		var/slot_var = "vice[slot]"
		
		switch(action)
			if("select", "change")
				// Show vice selection menu
				var/list/vices_available = list()
				
				// Get all currently selected vices to prevent duplicates
				var/list/selected_vices = list()
				for(var/i = 1 to 5)
					var/datum/charflaw/existing_vice = vars["vice[i]"]
					if(existing_vice)
						selected_vices += existing_vice.type
				
				for(var/vice_name in GLOB.character_flaws)
					var/datum/charflaw/vice_type = GLOB.character_flaws[vice_name]
					
					// Skip if already selected in another slot
					var/datum/charflaw/current_vice = vars[slot_var]
					if(vice_type in selected_vices && current_vice?.type != vice_type)
						continue
					
					vices_available[vice_name] = vice_type
				
				vices_available = sort_list(vices_available)
				var/choice = tgui_input_list(usr, "Select a vice for slot [slot]:", "Vice Selection", vices_available)
			
				if(choice)
					var/datum/charflaw/selected = vices_available[choice]
					vars[slot_var] = new selected()
					to_chat(usr, span_notice("Selected [choice] for vice slot [slot]."))
					var/datum/charflaw/new_vice = vars[slot_var]
					if(new_vice.desc)
						to_chat(usr, "<span class='info'>[new_vice.desc]</span>")
					save_preferences()
					open_vices_menu(usr)
			
			if("clear")
				if(slot == 1)
					to_chat(usr, span_warning("Vice slot 1 is required and cannot be cleared!"))
					return
				
				vars[slot_var] = null	
				save_preferences()
				open_vices_menu(usr)
	
	if(href_list["loadout_action"])
		var/action = href_list["loadout_action"]
		var/slot = text2num(href_list["slot"])
		
		if(!slot || slot < 1 || slot > 10)
			return
		
		var/slot_var = slot == 1 ? "loadout" : "loadout[slot]"
		
		switch(action)
			if("select", "change")
				// Show item selection menu
				var/list/loadouts_available = list("None")
				
				for(var/path as anything in GLOB.loadout_items)
					var/datum/loadout_item/item = GLOB.loadout_items[path]
					
					// Check if donator item
					if(item.donoritem && usr?.ckey)
						if(!item.donator_ckey_check(usr.ckey))
							continue
					
					// Show triumph cost in name
					var/display_name = item.name
					if(item.triumph_cost)
						display_name = "[item.name] (-[item.triumph_cost] TRI)"
					
					loadouts_available[display_name] = item
				
				var/choice = tgui_input_list(usr, "Select an item for slot [slot]:", "Loadout Selection", loadouts_available)
				
				if(choice && choice != "None")
					var/datum/loadout_item/selected = loadouts_available[choice]
					
					// Check triumph cost
					if(selected.triumph_cost)
						var/total_triumphs = usr.get_triumphs()
						var/spent_triumphs = 0
						
						// Calculate current spent (excluding this slot if changing)
						for(var/i = 1 to 10)
							if(i == slot)
								continue
							var/datum/loadout_item/other_slot = vars[i == 1 ? "loadout" : "loadout[i]"]
							if(other_slot && other_slot.triumph_cost)
								spent_triumphs += other_slot.triumph_cost
						
						if(spent_triumphs + selected.triumph_cost > total_triumphs)
							to_chat(usr, span_warning("You don't have enough triumphs! Need [selected.triumph_cost], but only have [total_triumphs - spent_triumphs] remaining."))
							return
					
					vars[slot_var] = selected
					to_chat(usr, span_notice("Selected [selected.name] for slot [slot]."))
				else
					vars[slot_var] = null
				
				save_preferences()
				open_vices_menu(usr)
			
			if("clear")
				vars[slot_var] = null
				vars["loadout_[slot]_name"] = null
				vars["loadout_[slot]_desc"] = null
				vars["loadout_[slot]_hex"] = null
				save_preferences()
				open_vices_menu(usr)
			
			if("rename")
				var/datum/loadout_item/current = vars[slot_var]
				if(!current)
					return
				
				var/new_name = tgui_input_text(usr, "Enter a custom name for this item (leave blank to use default):", "Rename Item", vars["loadout_[slot]_name"], MAX_NAME_LEN)
				
				if(new_name != null) // Allow empty string to clear
					vars["loadout_[slot]_name"] = new_name
					save_preferences()
					open_vices_menu(usr)
			
			if("describe")
				var/datum/loadout_item/current = vars[slot_var]
				if(!current)
					return
				
				var/new_desc = tgui_input_text(usr, "Enter a custom description for this item (leave blank to use default):", "Describe Item", vars["loadout_[slot]_desc"], max_length = 500, multiline = TRUE)
				
				if(new_desc != null) // Allow empty string to clear
					vars["loadout_[slot]_desc"] = new_desc
					save_preferences()
					open_vices_menu(usr)
			
			if("color")
				var/datum/loadout_item/current = vars[slot_var]
				if(!current)
					return
				
				var/new_color = input(usr, "Choose a color for this item:", "Item Color", vars["loadout_[slot]_hex"]) as color|null
				
				if(new_color)
					vars["loadout_[slot]_hex"] = new_color
					save_preferences()
					open_vices_menu(usr)
	
	if(href_list["language_action"])
		var/action = href_list["language_action"]
		
		// Handle free language
		if(action == "free_select" || action == "free_change")
			var/static/list/selectable_languages = list(
				/datum/language/elvish,
				/datum/language/dwarvish,
				/datum/language/orcish,
				/datum/language/hellspeak,
				/datum/language/draconic,
				/datum/language/celestial,
				/datum/language/canilunzt,
				/datum/language/grenzelhoftian,
				/datum/language/kazengunese,
				/datum/language/etruscan,
				/datum/language/gronnic,
				/datum/language/otavan,
				/datum/language/aavnic,
				/datum/language/merar,
				/datum/language/thievescant/signlanguage
			)
			var/list/choices = list("None")
			for(var/language in selectable_languages)
				if(language in pref_species.languages)
					continue
				var/datum/language/a_language = new language()
				choices[a_language.name] = language
				qdel(a_language)
			
			var/chosen_language = input(usr, "Choose your character's extra language:", "EXTRA LANGUAGE") as null|anything in choices
			if(chosen_language)
				if(chosen_language == "None")
					extra_language = "None"
				else
					extra_language = choices[chosen_language]
				save_preferences()
			open_vices_menu(usr)
			return
		
		// Handle triumph languages
		var/slot = text2num(href_list["slot"])
		
		if(!slot || slot < 1 || slot > 2)
			return
		
		var/slot_var = slot == 1 ? "extra_language_1" : "extra_language_2"
		
		switch(action)
			if("select", "change")
				// Show language selection menu
				var/static/list/selectable_languages = list(
					/datum/language/elvish,
					/datum/language/dwarvish,
					/datum/language/orcish,
					/datum/language/hellspeak,
					/datum/language/draconic,
					/datum/language/celestial,
					/datum/language/canilunzt,
					/datum/language/grenzelhoftian,
					/datum/language/kazengunese,
					/datum/language/etruscan,
					/datum/language/gronnic,
					/datum/language/otavan,
					/datum/language/aavnic,
					/datum/language/merar,
					/datum/language/thievescant/signlanguage
				)
				
				var/list/choices = list("None")
				for(var/language in selectable_languages)
					if(language in pref_species.languages)
						continue
					
					// Check if already selected in other slot
					var/other_slot_var = slot == 1 ? "extra_language_2" : "extra_language_1"
					if(vars[other_slot_var] == language)
						continue
					
					var/datum/language/a_language = new language()
					choices[a_language.name] = language
					qdel(a_language)
				
				var/chosen_language = input(usr, "Choose a language (2 triumphs each):", "Language Selection") as null|anything in choices
				
				if(chosen_language)
					if(chosen_language == "None")
						vars[slot_var] = "None"
					else
						var/language_path = choices[chosen_language]
						
						// Check triumph cost
						var/total_triumphs = 0
						if(usr && usr.client)
							total_triumphs = usr.get_triumphs() || 0
						var/spent_triumphs = 0
						
						// Count current language purchases (excluding this slot)
						var/other_slot_var = slot == 1 ? "extra_language_2" : "extra_language_1"
						if(vars[other_slot_var] && vars[other_slot_var] != "None")
							spent_triumphs += 2
							
						if(spent_triumphs + 2 > total_triumphs)
							to_chat(usr, span_warning("You don't have enough triumphs! Need 2, but only have [total_triumphs - spent_triumphs] remaining."))
							return
							
						vars[slot_var] = language_path
						to_chat(usr, span_notice("Selected [chosen_language] for language slot [slot]."))
					
					save_preferences()
				
				open_vices_menu(usr)
			
			if("clear")
				vars[slot_var] = "None"
				save_preferences()
				open_vices_menu(usr)
