{*
 * Copyright (c) 2004-2012 OIC Group, Inc.
 *
 * This file is part of Exponent
 *
 * Exponent is free software; you can redistribute
 * it and/or modify it under the terms of the GNU
 * General Public License as published by the Free
 * Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * GPL: http://www.gnu.org/licenses/gpl.txt
 *
 *}
 
<div class="module store show">
    {if $moduletitle && !$config.hidemoduletitle}<h1>{$moduletitle}</h1>{/if}
    {form action=search_by_model_old}
        {control type="text" name="search_string" label=" "}
        {control type="buttongroup" submit="Search"|gettext}
    {/form}
</div>