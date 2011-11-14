<?php

##################################################
#
# Copyright (c) 2004-2011 OIC Group, Inc.
# Written and Designed by James Hunt
#
# This file is part of Exponent
#
# Exponent is free software; you can redistribute
# it and/or modify it under the terms of the GNU
# General Public License as published by the Free
# Software Foundation; either version 2 of the
# License, or (at your option) any later version.
#
# GPL: http://www.gnu.org/licenses/gpl.txt
#
##################################################

/**
 * Smarty plugin
 * @package Smarty-Plugins
 * @subpackage Modifier
 */

/**
 * Smarty {is_logged_in} modifier plugin
 *
 * Type:     modifier<br>
 * Name:     is_logged_in<br>
 * Purpose:  determine if user is logged in
 *
 * @param array
 * @return array
 */
function smarty_modifier_is_logged_in($string) {
	if(expSession::loggedIn()) {
		return true; 
	} else {
		return false;
	}
}

?>
