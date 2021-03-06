{*
 * Copyright (c) 2004-2013 OIC Group, Inc.
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

<div class="item">
	<h3{if $config.usecategories} class="{$cat->color}"{/if}><a href="{link action=show title=$record->sef_url}" title="{$record->body|summarize:"html":"para"}">{$record->title}</a></h3>
	{permissions}
		<div class="item-actions">
			{if $permissions.edit == 1}
                {if $myloc != $record->location_data}
                    {if $permissions.manage == 1}
                        {icon action=merge id=$record->id title="Merge Aggregated Content"|gettext}
                    {else}
                        {icon img='arrow_merge.png' title="Merged Content"|gettext}
                    {/if}
                {/if}
				{icon action=edit record=$record title="Edit `$record->title`"}
			{/if}
			{if $permissions.delete == 1}
				{icon action=delete record=$record title="Delete `$record->title`"}
			{/if}
		</div>
	{/permissions}
    {tags_assigned record=$record}
    <div class="bodycopy">
        {if $config.filedisplay != "Downloadable Files"}
            {filedisplayer view="`$config.filedisplay`" files=$record->expFile record=$record is_listing=1}
        {/if}
        {if $config.usebody==1}
            <p>{$record->body|summarize:"html":"paralinks"}</p>
        {elseif $config.usebody==2}
        {else}
            {$record->body}
        {/if}
        {if $config.filedisplay == "Downloadable Files"}
            {filedisplayer view="`$config.filedisplay`" files=$record->expFile record=$record is_listing=1}
        {/if}
    </div>
    {clear}
    {permissions}
        {if $permissions.create == 1}
            <div class="module-actions">
                {icon class="add" action=edit rank=$record->rank+1 title="Add another here"|gettext  text="Add a portfolio piece here"|gettext}
            </div>
        {/if}
    {/permissions}
</div>