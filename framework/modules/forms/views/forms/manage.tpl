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

{css unique="manageforms" corecss="admin-global,tables"}

{/css}

<div class="module forms manage">
    <div class="info-header">
        <div class="related-actions">
            {help text="Get Help"|gettext|cat:" "|cat:("Managing Forms"|gettext) module="forms-configuration"}
        </div>
        <h2>{"Site Forms Manager"|gettext}</h2>
    </div>
    <div class="module-actions">
        {icon class="add" action="edit_form" text="Create a New Form"|gettext}
    </div>
    <table border="0" cellspacing="0" cellpadding="0" class="exp-skin-table">
        <thead>
            <tr>
                <th>
                    {"Form Name"|gettext}
                </th>
                <th>
                    {"Saved to Database"|gettext}
                </th>
                <th width="37%">
                    {"Action"|gettext}
                </th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$forms item=form}
                <tr class="{cycle values="odd,even"}">
                    <td>
                        {$form->title}
                    </td>
                    <td>
                        {if $form->is_saved}
                            {'Yes'|gettext}
                        {else}
                            {'No'|gettext}
                        {/if}
                    </td>
                    <td>
                        <div class="item-actions">
                            {icon class=edit action=edit_form record=$form title="Edit this Form"|gettext}
                            {icon class=copy action=edit_form copy=1 record=$form title="Copy this Form"|gettext}
                            {icon class=configure action=design_form record=$form text="Design"|gettext title="Design this Form"|gettext}
                            {icon class=delete action=delete_form record=$form title="Delete this Form"|gettext onclick="return confirm('"|cat:("Are you sure you want to delete this form and ALL the saved data?"|gettext)|cat:"');"}
                        </div>
                    </td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>
