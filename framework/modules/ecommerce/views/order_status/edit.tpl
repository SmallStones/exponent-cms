{*
 * Copyright (c) 2004-2011 OIC Group, Inc.
 * Written and Designed by Adam Kessler
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

<div class="module order_status edit">
    <h1>
        {if $record->id == ""}New Order Status{else}Editing {$record->title}{/if}
    </h1>
    
    {form action=update}
        {control type="hidden" name="id" value=$record->id}
        {control type="text" name="title" label="Status Name" value=$record->title}
        {control type="checkbox" name="is_default" label="Default?" value=1 checked=$record->is_default}
        {control type="checkbox" name="treat_as_closed" label="Treat as Closed?" value=1 checked=$record->treat_as_closed}
        {control type="buttongroup" submit="Submit"|gettext cancel="Cancel"|gettext}
    {/form}
</div>
