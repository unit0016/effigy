#define LOOC_RANGE 7

/mob/proc/get_top_level_mob()
	if(ismob(loc) && (loc != src))
		var/mob/M = loc
		return M.get_top_level_mob()
	return src

/mob/living/verb/emote_whisper()
	set name = "Emote Whisper"
	set category = "IC"
	if(GLOB.say_disabled)
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return
	usr.emote("emotew")

/mob/living/verb/emote_quick()
	set name = "Emote Quick"
	set category = "IC"
	if(GLOB.say_disabled)
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return
	winset(client, null, "command=[client.tgui_say_create_open_command(ME_CHANNEL)]")

/client/verb/looc(msg as text)
	set name = "LOOC"
	set desc = "Local OOC, seen only by those in view."
	set category = "OOC"

	looc_message(msg)

/client/proc/looc_message(msg)
	if(GLOB.say_disabled)
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return

	if(!mob)
		return

	msg = copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)
		return

	if(!holder)
		if(!GLOB.looc_allowed)
			to_chat(src, span_danger("LOOC is globally muted."))
			return
		if(handle_spam_prevention(msg, MUTE_OOC))
			return
		if(findtext(msg, "byond://"))
			to_chat(src, span_boldannounce("<B>Advertising other servers is not allowed.</B>"))
			log_admin("[key_name(src)] has attempted to advertise in LOOC: [msg]")
			return
		if(prefs.muted & MUTE_LOOC)
			to_chat(src, span_danger("You cannot use LOOC (muted)."))
			return
		if(is_banned_from(ckey, BAN_LOOC))
			to_chat(src, span_warning("You are LOOC banned!"))
			return
		if(mob.stat)
			to_chat(src, span_danger("You cannot use LOOC while unconscious or dead."))
			return
		if(istype(mob, /mob/dead))
			to_chat(src, span_danger("You cannot use LOOC while ghosting."))
			return

	msg = emoji_parse(msg)

	mob.log_talk(msg,LOG_OOC, tag="LOOC")
	var/list/heard = get_hearers_in_view(LOOC_RANGE, mob.get_top_level_mob())

	//so the ai can post looc text
	if(istype(mob, /mob/living/silicon/ai))
		var/mob/living/silicon/ai/ai = mob
		heard = get_hearers_in_view(LOOC_RANGE, ai.eyeobj)
	//so the ai can see looc text
	for(var/mob/living/silicon/ai/ai as anything in GLOB.ai_list)
		if(ai.client && !(ai in heard) && (ai.eyeobj in heard))
			heard += ai

	var/list/admin_seen = list()
	for(var/mob/hearing in heard)
		if(!hearing.client)
			continue
		var/client/hearing_client = hearing.client
		if (hearing_client.holder)
			admin_seen[hearing_client] = TRUE
			continue //they are handled after that

		if (isobserver(hearing))
			continue //Also handled later.

		to_chat(hearing_client, span_looc(span_prefix("LOOC:</span> <EM>[src.mob.name]:</EM> <span class='message'>[msg]")))

	for(var/cli in GLOB.admins)
		var/client/cli_client = cli
		if (admin_seen[cli_client])
			to_chat(cli_client, span_looc("[ADMIN_FLW(usr)] <span class='prefix'>LOOC:</span> <EM>[src.key]/[src.mob.name]:</EM> <span class='message'>[msg]</span>"))
		else if (cli_client.prefs.read_preference(/datum/preference/toggle/admin/see_looc))
			to_chat(cli_client, span_rlooc("[ADMIN_FLW(usr)] <span class='prefix'>(R)LOOC:</span> <EM>[src.key]/[src.mob.name]:</EM> <span class='message'>[msg]</span>"))

#undef LOOC_RANGE
